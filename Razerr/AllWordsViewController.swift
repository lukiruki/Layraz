//
//  AllWordsViewController.swift
//  Razerr
//
//  Created by Aplikacje on 04/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit
import AVFoundation

class AllWordsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, ButtonCellDelegate {

    let speechSynthesizer = AVSpeechSynthesizer()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordsCell", for: indexPath) as! AllWordsTableViewCell
        
        cell.polishWordLabel.text = "Słowko"
        
        if cell.buttonDelegate == nil {
            cell.buttonDelegate = self
        }
        
        return cell
    }
    
    
    func cellTapped(_ cell: AllWordsTableViewCell) {
        self.showAlertForRow((tableView.indexPath(for: cell)?.row)!)
    }
   
    func showAlertForRow(_ row: Int) {
        print("Cell at row \(row) was tapped!")
        
        if !speechSynthesizer.isSpeaking {
            
            let textParagraphs = "Winner"
            let speechUtterance = AVSpeechUtterance(string: textParagraphs)
            speechUtterance.postUtteranceDelay = 0.005
            speechUtterance.voice =  AVSpeechSynthesisVoice(language: "en-AU")
            speechSynthesizer.speak(speechUtterance)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectCell =  tableView.cellForRow(at: indexPath)
         selectCell?.backgroundColor = UIColor.clear
    }
    
   
}
