//
//  ReadingViewController.swift
//  Razerr
//
//  Created by Aplikacje on 04/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

class ReadingViewController: UIViewController, AVSpeechSynthesizerDelegate,SettingsViewControllerDelegate  {

    @IBOutlet weak var tvEditor: UITextView!
    
    @IBOutlet weak var btnSpeak: UIButton!
    
    @IBOutlet weak var btnPause: UIButton!
    
    @IBOutlet weak var btnStop: UIButton!
    
    
    var preferredVoiceLanguageCode: String!
    
    var rate: Float!
    
    var pitch: Float!
    
    var volume: Float!
    
    var totalUtterances: Int! = 0
    
    var currentUtterance: Int! = 0
    
    var totalTextLength: Int = 0
    
    var spokenTextLengths: Int = 0
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var previousSelectedRange: NSRange!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        speechSynthesizer.delegate = self
        // Make the corners of the textview rounded and the buttons look like circles.
        tvEditor.layer.cornerRadius = 15.0
        btnSpeak.layer.cornerRadius = 40.0
        btnPause.layer.cornerRadius = 40.0
        btnStop.layer.cornerRadius = 40.0
        tvEditor.text = "Have you ever dreamed of running a bookshop? You can have a go for a week at the Open Book Store in Wigton, Scotland. In fact, if you book a holiday at the self-catering flat on Airbnb, you also have to work for 40 hours in the bookshop downstairs. A week in the flat costs £150. You won’t get paid for working, but you can use your own creative ideas to sell books and gain valuable experience. Wigton is Scotland’s national book town and this new venture is attracting interest from all over the world."
        // Set the initial alpha value of the following buttons to zero (make them invisible).
        btnPause.alpha = 0.0
        btnStop.alpha = 0.0
        
        // Make the progress view invisible and set is initial progress to zero.

        
        
        // Create a swipe down gesture for hiding the keyboard.
        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ReadingViewController.handleSwipeDownGesture(_:)))
        swipeDownGestureRecognizer.direction = UISwipeGestureRecognizerDirection.down
        view.addGestureRecognizer(swipeDownGestureRecognizer)
        
        if !loadSettings() {
            registerDefaultSettings()
        }
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "idSegueSettings" {
            let settingsViewController = segue.destination as! SettingsViewController
            settingsViewController.delegate = self
        }
    }
    
    func didSaveSettings() {
        let settings = UserDefaults.standard as UserDefaults!
        
        rate = settings?.value(forKey: "rate") as! Float
        pitch = settings?.value(forKey: "pitch") as! Float
        volume = settings?.value(forKey: "volume") as! Float
//         preferredVoiceLanguageCode = settings?.value(forKey: "languageCode") as! String
    }
    
    func handleSwipeDownGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        tvEditor.resignFirstResponder()
    }
    
    func registerDefaultSettings() {
        
        rate = AVSpeechUtteranceDefaultSpeechRate
        pitch = 1.0
        volume = 1.0
        
        var defaultSpeechSettings: [String : AnyObject] = ["rate": rate as AnyObject, "pitch": pitch as AnyObject, "volume": volume as AnyObject]
        
        UserDefaults.standard.register(defaults: defaultSpeechSettings)
        
    }
    
    
    
    func loadSettings() -> Bool {
        let userDefaults = UserDefaults.standard as UserDefaults
        
        if let theRate: Float = userDefaults.value(forKey: "rate") as? Float {
            rate = theRate
            pitch = userDefaults.value(forKey: "pitch") as! Float
            volume = userDefaults.value(forKey: "volume") as! Float
            
            return true
        }
        
        return false
    }
    
    // MARK: IBAction method implementation
    
    @IBAction func speak(_ sender: AnyObject) {
        if !speechSynthesizer.isSpeaking {
            
            let textParagraphs = tvEditor.text.components(separatedBy:"\n")
            
            // Add these lines.
            totalUtterances = textParagraphs.count
            currentUtterance = 0
            totalTextLength = 0
            spokenTextLengths = 0
            
            for pieceOfText in textParagraphs {
                let speechUtterance = AVSpeechUtterance(string: pieceOfText)
                speechUtterance.rate = rate
                speechUtterance.pitchMultiplier = pitch
                speechUtterance.volume = volume
                speechUtterance.postUtteranceDelay = 0.005
                speechUtterance.voice =  AVSpeechSynthesisVoice(language: "en-AU")
                
                //                if let voiceLanguageCode = preferredVoiceLanguageCode {
                //                    let voice = AVSpeechSynthesisVoice(language: "com.apple.ttsbundle.siri_female_en-AU_compact")
                //                    speechUtterance.voice = voice
                //                }
                totalTextLength = totalTextLength + pieceOfText.utf16.count
                
                speechSynthesizer.speak(speechUtterance)
            }
        }
        else{
            speechSynthesizer.continueSpeaking()
        }
        
        animateActionButtonAppearance(shouldHideSpeakButton: true)
    }
    
    
    @IBAction func pauseSpeech(_ sender: AnyObject) {
        speechSynthesizer.pauseSpeaking(at: AVSpeechBoundary.word)
        animateActionButtonAppearance(shouldHideSpeakButton: false)
    }
    
    
    @IBAction func stopSpeech(_ sender: AnyObject) {
        speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        animateActionButtonAppearance(shouldHideSpeakButton: false)
    }
    
    
    func animateActionButtonAppearance(shouldHideSpeakButton: Bool) {
        var speakButtonAlphaValue: CGFloat = 1.0
        var pauseStopButtonsAlphaValue: CGFloat = 0.0
        
        if shouldHideSpeakButton {
            speakButtonAlphaValue = 0.0
            pauseStopButtonsAlphaValue = 1.0
        }
        
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.btnSpeak.alpha = speakButtonAlphaValue
            self.btnPause.alpha = pauseStopButtonsAlphaValue
            self.btnStop.alpha = pauseStopButtonsAlphaValue

        })
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didFinishSpeechUtterance utterance: AVSpeechUtterance!) {
        spokenTextLengths = spokenTextLengths + utterance.speechString.utf16.count + 1
        
  
        
        if currentUtterance == totalUtterances {
            animateActionButtonAppearance(shouldHideSpeakButton: false)
            previousSelectedRange = nil
        }
    }
    
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didStartSpeechUtterance utterance: AVSpeechUtterance!) {
        currentUtterance = currentUtterance + 1
    }
    
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance!) {
      
     
        
        // set  selected text -------------
        
        
        // Determine the current range in the whole text (all utterances), not just the current one.
        let rangeInTotalText = NSMakeRange(spokenTextLengths + characterRange.location, characterRange.length)
        
        // Select the specified range in the textfield.
        tvEditor.selectedRange = rangeInTotalText
        
        // Store temporarily the current font attribute of the selected text.
        let currentAttributes = tvEditor.attributedText.attributes(at: rangeInTotalText.location, effectiveRange: nil)
        let fontAttribute: AnyObject? = currentAttributes[NSFontAttributeName] as AnyObject?
        
        // Assign the selected text to a mutable attributed string.
        let attributedString = NSMutableAttributedString(string: tvEditor.attributedText.attributedSubstring(from: rangeInTotalText).string)
        
        // Make the text of the selected area orange by specifying a new attribute.
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.orange, range: NSMakeRange(0, attributedString.length))
        
        // Make sure that the text will keep the original font by setting it as an attribute.
        attributedString.addAttribute(NSFontAttributeName, value: fontAttribute!, range: NSMakeRange(0, attributedString.string.utf16.count))
        
        // In case the selected word is not visible scroll a bit to fix this.
        tvEditor.scrollRangeToVisible(rangeInTotalText)
        
        // Begin editing the text storage.
        tvEditor.textStorage.beginEditing()
        
        // Replace the selected text with the new one having the orange color attribute.
        tvEditor.textStorage.replaceCharacters(in: rangeInTotalText, with: attributedString)
        
        // If there was another highlighted word previously (orange text color), then do exactly the same things as above and change the foreground color to black.
        if let previousRange = previousSelectedRange {
            let previousAttributedText = NSMutableAttributedString(string: tvEditor.attributedText.attributedSubstring(from: previousRange).string)
            previousAttributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSMakeRange(0, previousAttributedText.length))
            previousAttributedText.addAttribute(NSFontAttributeName, value: fontAttribute!, range: NSMakeRange(0, previousAttributedText.length))
            
            tvEditor.textStorage.replaceCharacters(in: previousRange, with: previousAttributedText)
        }
        
        // End editing the text storage.
        tvEditor.textStorage.endEditing()
        
        // Keep the currently selected range so as to remove the orange text color next.
        previousSelectedRange = rangeInTotalText
    }
    
    
  

}
