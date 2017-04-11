//
//  SettingsViewController.swift
//  Razerr
//
//  Created by Aplikacje on 09/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

protocol SettingsViewControllerDelegate {
    func didSaveSettings()
}


class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    @IBOutlet weak var tbSettings: UITableView!
    
    
    var delegate: SettingsViewControllerDelegate!
    
    let speechSettings = UserDefaults.standard
    
    var rate: Float!
    
    var pitch: Float!
    
    var volume: Float!
    
    
    var arrVoiceLanguages: [Dictionary<String,String>] = [[:]]
    
    var selectedVoiceLanguage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Make self the delegate and datasource of the tableview.
        tbSettings.delegate = self
        tbSettings.dataSource = self
        
        // Make the table view with rounded contents.
        tbSettings.layer.cornerRadius = 15.0
        
        rate = speechSettings.value(forKey: "rate") as! Float
        pitch = speechSettings.value(forKey: "pitch") as! Float
        volume = speechSettings.value(forKey: "volume") as! Float
        
        prepareVoiceList()
        
        for (key, value) in arrVoiceLanguages.enumerated() {
            print(key)
            print(value)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareVoiceList() {
        for voice in AVSpeechSynthesisVoice.speechVoices() {
            let voiceLanguageCode = (voice as AVSpeechSynthesisVoice).language
            let languageName = (Locale.current as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: voiceLanguageCode)
            let dictionary = ["languageName": languageName, "languageCode": voiceLanguageCode]
            
            arrVoiceLanguages.append(dictionary as! [String : String])
        }
    }
    
    
    // MARK: UITableView method implementation
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let voiceLanguagesDictionary = arrVoiceLanguages[row + 1]["languageName"]! as String
        
        return voiceLanguagesDictionary
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrVoiceLanguages.count/2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        if indexPath.row < 3 {
            cell = tableView.dequeueReusableCell(withIdentifier: "idRateSlider", for: indexPath) as UITableViewCell
            
            let keyLabel = cell.contentView.viewWithTag(10) as? UILabel
            let valueLabel = cell.contentView.viewWithTag(20) as? UILabel
            
            var value: Float = 0.0
            switch indexPath.row {
                
            case 0:
                value = rate
                
                keyLabel?.text = "Rate"
                valueLabel?.text = NSString(format: "%.2f", rate) as String
                
            case 1:
                value = pitch
                
                keyLabel?.text = "Pitch"
                valueLabel?.text = NSString(format: "%.2f", pitch) as String
                
            default:
                value = volume
                
                keyLabel?.text = "Volume"
                valueLabel?.text = NSString(format: "%.2f", volume) as String
            }
            
            let slider = cell.contentView.viewWithTag(30) as! CustomSlider
            
            switch indexPath.row {
            case 0:
                slider.minimumValue = AVSpeechUtteranceMinimumSpeechRate
                slider.maximumValue = AVSpeechUtteranceMaximumSpeechRate
                slider.addTarget(self, action:#selector(handleSliderValueChange(sender:)), for: .valueChanged)
                slider.sliderIdentifier = 100
                
            case 1:
                slider.minimumValue = 0.5
                slider.maximumValue = 2.0
                slider.addTarget(self, action:#selector(handleSliderValueChange(sender:)), for: .valueChanged)
                slider.sliderIdentifier = 200
                
            default:
                slider.minimumValue = 0.0
                slider.maximumValue = 1.0
                slider.addTarget(self, action:#selector(handleSliderValueChange(sender:)), for: .valueChanged)
                slider.sliderIdentifier = 300
            }
            
            if slider.value != value {
                slider.value = value
            }
            
        }
        else{
            print("Dostalem sie")
            cell = tableView.dequeueReusableCell(withIdentifier: "idCellVoicePicker", for: indexPath) as UITableViewCell
            
            let pickerView = cell.contentView.viewWithTag(10) as! UIPickerView
            pickerView.delegate = self
            pickerView.dataSource = self
        }
        
        return cell
    }
    
    func handleSliderValueChange(sender: CustomSlider) {
        
        switch sender.sliderIdentifier {
        case 100:
            rate = sender.value
            
        case 200:
            pitch = sender.value
            
        default:
            volume = sender.value
        }
        
        tbSettings.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 3 {
            return 100.0
        }
        else{
            return 170.0
        }
    }
    
    
    // MARK: IBAction method implementation
    
    @IBAction func saveSettings(_ sender: AnyObject) {
        UserDefaults.standard.set(rate, forKey: "rate")
        UserDefaults.standard.set(pitch, forKey: "pitch")
        UserDefaults.standard.set(volume, forKey: "volume")
        // UserDefaults.standard.set(arrVoiceLanguages[selectedVoiceLanguage]["languageCode"], forKey: "languageCode")
        UserDefaults.standard.synchronize()
        
        self.delegate.didSaveSettings()
        
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: Custom method implementation
    
}
