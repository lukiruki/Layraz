//
//  NotificationsViewController.swift
//  Razerr
//
//  Created by Aplikacje on 22/03/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit
import UserNotifications
import Alamofire
import SwiftyJSON

class NotificationsViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var pickerhoursMorning: UIPickerView!
    @IBOutlet weak var pickerminuteMorning: UIPickerView!
    
    @IBOutlet weak var pickerWordsminute: UIPickerView!
    
    @IBOutlet weak var hoursmorningLabel: UILabel!
    @IBOutlet weak var minutemorningLabel: UILabel!
    @IBOutlet weak var minutewordsLabel: UILabel!
    
    @IBOutlet weak var morningButton: UIButton!
    @IBOutlet weak var wordsButton: UIButton!
    
  
    var hoursMorning: [String] = []
    var minuteMorning: [String] = []
    var minutewords: [String] = []
    var blurEffectView: UIVisualEffectView?
    
    let center = UNUserNotificationCenter.current()
    var mainApi = ListeningApi()
    var listenWordsNotifications: [NotificationsWordsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllWordsWithAlamofire()
        
        let array = arrayforList()
        
        initializeArray(array: array)
        setDelegateandDataSource()
        hiddenButton()
        
    }
    
    private func hiddenButton() {
        morningButton.isEnabled = false
        
    }
    
    private func setDelegateandDataSource() {
    
        self.pickerhoursMorning.delegate = self
        self.pickerhoursMorning.dataSource = self
        morningButton.layer.cornerRadius = 3.0
        
        self.pickerminuteMorning.delegate = self
        self.pickerminuteMorning.dataSource = self
        
        self.pickerWordsminute.delegate = self
        self.pickerWordsminute.dataSource = self
        wordsButton.layer.cornerRadius = 3.0
        

    }
    
    private func initializeArray(array: Array<String>) {
        hoursMorning = ["05","06","07","08","09","10","11","12","13"]
        minuteMorning = array
        minutewords = ["10","20","30","40","50","60","90","120"]

    }

    
    private func arrayforList() -> Array<String> {
        var array: [String] = []
        for i in 0..<60 {
            if i >= 1 && i<=9 {
                array.append("0" + String(i))
            }
            if i >= 10 && i <= 59 {
                array.append(String(i))

            }
        }
        return array
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return hoursMorning.count
        } else if pickerView.tag == 2 {
            return minuteMorning.count
        }
        return minutewords.count
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return hoursMorning[row]
        } else if pickerView.tag == 2 {
            return minuteMorning[row]
        }
        return minutewords[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString: NSAttributedString!
        if pickerView.tag == 1 {
            attributedString = NSAttributedString(string: hoursMorning[row], attributes: [NSForegroundColorAttributeName : UIColor.white])
        } else if pickerView.tag == 2 {
            attributedString = NSAttributedString(string: minuteMorning[row], attributes: [NSForegroundColorAttributeName : UIColor.white])
        } else if pickerView.tag == 3 {
            attributedString = NSAttributedString(string: minutewords[row], attributes: [NSForegroundColorAttributeName : UIColor.white])
        }
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
           hoursmorningLabel.text =  hoursMorning[row]
        } else if pickerView.tag == 2 {
           minutemorningLabel.text = minuteMorning[row]
            morningButton.isEnabled = true
        } else if pickerView.tag == 3 {
           minutewordsLabel.text =  minutewords[row]
            wordsButton.isEnabled = true
        }
        
    }
    
    
    @IBAction func TurnMorning(_ sender: Any) {
        
        
        let content = UNMutableNotificationContent()
        content.title = "Witaj w mojej aplikacji"
        content.body = "Mozesz uaktywnic opcję powtarzania słówek lub uaktywnienia pakietu do nauki."
        content.sound = UNNotificationSound.default()
        
                if let path = Bundle.main.path(forResource: "logo", ofType: "png") {
                    let url = URL(fileURLWithPath: path)
        
                    do {
                        let attachment = try UNNotificationAttachment(identifier: "logo", url: url, options: nil)
                        content.attachments = [attachment]
                    } catch {
                        print("The attachment was not loaded.")
                    }
                }
        
        var dateComponents = DateComponents()
        if (!(hoursmorningLabel.text?.isEmpty)! && !(minutemorningLabel.text?.isEmpty)!){
            dateComponents.hour = Int(hoursmorningLabel.text!)
            dateComponents.minute = Int(minutemorningLabel.text!)
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        let morningIndentifier = "morningIdentifier"
        let setWords = UNNotificationAction(identifier: "setWordsandPakietforMorning", title: "Ustaw słówka oraz pakiet", options: [.foreground])
        let doneButton = UNNotificationAction(identifier: "freefromLearningMorning", title: "Dzisiaj mam wolne od nauki", options: [])
        let category = UNNotificationCategory(identifier: morningIndentifier, actions: [setWords,doneButton], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        content.categoryIdentifier = morningIndentifier
       
        let request = UNNotificationRequest(identifier: "Morning", content: content, trigger: trigger)
        center.add(request)
        print("Nacisnales przycisk Morning")

    }
    
    func WordsNotifications(english: String, polish: String){
        
        let content = UNMutableNotificationContent()
        content.title = polish
        content.body = english
        content.sound = UNNotificationSound.default()
        
        if let path = Bundle.main.path(forResource: "logo", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "logo", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }
        }
        
//        var dateComponents = DateComponents()
//        if (!(hoursmorningLabel.text?.isEmpty)! && !(minutemorningLabel.text?.isEmpty)!){
//            dateComponents.hour = Int(hoursmorningLabel.text!)
//            dateComponents.minute = Int(minutemorningLabel.text!)
//        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 61, repeats: true)
        
        let categoryIndentifier = "wordIdentifier"
        let makeWords = UNNotificationAction(identifier: "makeWords", title: "Zapamietaj mnie", options: [])
        let addRemind = UNNotificationAction(identifier: "addRemind", title: "Powtórz słówko", options: [])
        let category = UNNotificationCategory(identifier: categoryIndentifier, actions: [makeWords,addRemind], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        content.categoryIdentifier = categoryIndentifier
        let request = UNNotificationRequest(identifier: "Words", content: content, trigger: trigger)
        center.add(request)
        print("Nacisnales przycisk Words")
    }
    
    
    
    @IBAction func TurnWords(_ sender: Any) {
        wordsButton.layer.backgroundColor = UIColor(red: 216.0/255.0, green: 74.0/255.0, blue: 32.0/255.0, alpha: 1.0).cgColor
        let allincrease = UserDefaults.standard.integer(forKey: "allincreaseWords")
        var selected = setSelectedWordsforIndex(increase: allincrease)
        WordsNotifications(english: selected.0, polish: selected.1)
    }
    
   
   
    
    func setPacketNotifications(increase: Int) {
    
        print("Jestes w pakiecie")
        let allincrease = UserDefaults.standard.integer(forKey: "allincreaseWords")
        var setAllWordsforUser = allincrease + increase
        UserDefaults.standard.set(setAllWordsforUser, forKey: "allincreaseWords")
        
        
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
        
        let content = UNMutableNotificationContent()
        content.title = "Pakiet na dzisiejszy dzień"
        content.body = "Witam, proszę przejsc do nauki."
        content.sound = UNNotificationSound.default()
        
        if let path = Bundle.main.path(forResource: "logo", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "logo", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }
        }
    
        
        let packetIndentifier = "packetIdentifier"
        let setWords = UNNotificationAction(identifier: "gotToPacketLearning", title: "Przejdz do nauki z pakietu", options: [.foreground])
        let category = UNNotificationCategory(identifier: packetIndentifier, actions: [setWords], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        content.categoryIdentifier = packetIndentifier
        
        let request = UNNotificationRequest(identifier: "Packet", content: content, trigger: nil)
        center.add(request)
        print("Nacisnales przycisk")

    }
    
    
    func setSelectedWordsforIndex(increase: Int) -> (String,String){
        var userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "teams") as! Data
        let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [NotificationsWordsModel]
        return(decodedTeams[increase].englishword, decodedTeams[increase].polishword)
    }
    
    
    
    
    func makeforRemberWords() {
        let increase = UserDefaults.standard.integer(forKey: "increaseWords")
        print("Increase wynosi",increase)
        if increase == 2 {
            setPacketNotifications(increase: increase)
            UserDefaults.standard.set(0, forKey: "increaseWords")
        } else {
            var selected = setSelectedWordsforIndex(increase: increase)
            WordsNotifications(english: selected.0, polish: selected.1)
        }
    }
    func makeforNotRemeber() {
        print("Lepiej powtorz")
    }
   
    
    func getAllWordsWithAlamofire() {
        let urlString = "https://parseapi.back4app.com/classes/eWords"
        
        let queue = DispatchQueue(label: "com.cnoon.manager-response-queue",qos: .userInitiated,attributes:.concurrent)
        
        let headers: HTTPHeaders = [
            "X-Parse-Application-Id": "DvGa4MJJh3REJP3Q8tAqZDzuAbVPpHW7ZD5k5R25",
            "X-Parse-REST-API-Key": "Y0mspj596kgiy2QpVKO7ohfIoEF06fYw272wT1Xt",
            "Accept": "application/json"
        ]
        
        Alamofire.request(urlString, method: .get,encoding: JSONEncoding.default, headers: headers).responseJSON(queue: queue, completionHandler: { response in
            switch response.result {
            case .success:
                // print(response)
                
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    print(value)
                    for index in 0..<20 {
                        var polishword = json["results"][index]["polishword"].stringValue
                        var englishWord = json["results"][index]["englishword"].stringValue
                        var word = NotificationsWordsModel(polishword: polishword, englishword: englishWord)
                        self.listenWordsNotifications.append(word)
                        
                    }
                    DispatchQueue.main.async {
                        print("Lista w alamo", self.listenWordsNotifications.count)
                        
                        var wordsDefaults = UserDefaults.standard
                        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.listenWordsNotifications)
                        wordsDefaults.set(encodedData, forKey: "teams")
                        wordsDefaults.synchronize()
                        
                    }
                    
                    
                }
                break
            case .failure(let error):
                
                print(error)
                break
            }
            
        }
        )

    }

}










