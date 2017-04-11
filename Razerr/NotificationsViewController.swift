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
    @IBOutlet weak var pickerhoursAfternoon: UIPickerView!
    @IBOutlet weak var pickerminuteAfternoon: UIPickerView!
    
    @IBOutlet weak var pickerwords: UIPickerView!
    @IBOutlet weak var amountCompleteDaysImage: UIImageView!
    @IBOutlet weak var numberhoursstudyImage: UIImageView!
    @IBOutlet weak var numberofWordsImage: UIImageView!
    
   
    @IBOutlet weak var hoursmorningLabel: UILabel!
    @IBOutlet weak var minutemorningLabel: UILabel!
    @IBOutlet weak var minutewordsLabel: UILabel!
    @IBOutlet weak var minuteafternoonLabel: UILabel!
    @IBOutlet weak var hoursafternoonLabel: UILabel!
    
    @IBOutlet weak var morningButton: UIButton!
    @IBOutlet weak var afternoonButton: UIButton!
    @IBOutlet weak var wordsButton: UIButton!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var hoursMorning: [String] = []
    var minuteMorning: [String] = []
    var hoursAfternoon: [String] = []
    var minuteAfternoon: [String] = []
    var minutewords: [String] = []
    var blurEffectView: UIVisualEffectView?
    
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
        afternoonButton.isEnabled = false
        //wordsButton.isEnabled = false
    }
    
    private func setDelegateandDataSource() {
    
        self.pickerhoursMorning.delegate = self
        self.pickerhoursMorning.dataSource = self
        
        self.pickerminuteMorning.delegate = self
        self.pickerminuteMorning.dataSource = self
        
        self.pickerhoursAfternoon.delegate = self
        self.pickerhoursAfternoon.dataSource = self
        
        self.pickerminuteAfternoon.delegate = self
        self.pickerminuteAfternoon.dataSource = self

    }
    
    private func initializeArray(array: Array<String>) {
        hoursMorning = ["05","06","07","08","09","10","11","12"]
        minuteMorning = array
        hoursAfternoon = ["08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]
        minuteAfternoon = array
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
        } else if  pickerView.tag == 3 {
            return hoursAfternoon.count
        } else if  pickerView.tag == 4 {
            return minuteAfternoon.count
        }
        return minutewords.count
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return hoursMorning[row]
        } else if pickerView.tag == 2 {
            return minuteMorning[row]
        } else if  pickerView.tag == 3 {
            return hoursAfternoon[row]
        } else if  pickerView.tag == 4 {
            return minuteAfternoon[row]
        }
        return minutewords[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
           hoursmorningLabel.text =  hoursMorning[row]
        } else if pickerView.tag == 2 {
           minutemorningLabel.text = minuteMorning[row]
            morningButton.isEnabled = true
        } else if  pickerView.tag == 3 {
           hoursafternoonLabel.text = hoursAfternoon[row]
               afternoonButton.isEnabled = true
        } else if  pickerView.tag == 4 {
           minuteafternoonLabel.text = minuteAfternoon[row]
          
        } else if pickerView.tag == 5 {
           minutewordsLabel.text =  minutewords[row]
         //   wordsButton.isEnabled = true
        }
        
    }
    
    
    @IBAction func TurnMorning(_ sender: Any) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = listenWordsNotifications[0].polishword
        content.body = listenWordsNotifications[0].englishword
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
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
        
        let request = UNNotificationRequest(identifier: "Morning", content: content, trigger: trigger)
        center.add(request)
        print("Nacisnales przycisk")

    }
    
   
   
    
    @IBAction func TurnOnOffAfternoonButton(_ sender: UIButton) {
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "asdsadsadasd"
        content.body = "blalalalalalalalalalal."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
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
        if (!(hoursafternoonLabel.text?.isEmpty)! && !(minuteafternoonLabel.text?.isEmpty)!){
            dateComponents.hour = Int(hoursafternoonLabel.text!)
            dateComponents.minute = Int(minuteafternoonLabel.text!)
        }
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "Dane", content: content, trigger: trigger)
        center.add(request)
        print("Nacisnales przycisk")

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










