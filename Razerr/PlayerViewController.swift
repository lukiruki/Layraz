//
//  PlayerViewController.swift
//  Razerr
//
//  Created by Aplikacje on 23/03/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var convertImageView: UIImageView!
    @IBOutlet weak var songTitlelabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var startstopActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var startstopButton: UIButton!
    
    var selectlistenDetailModel: AllListeningDetailModel?
    var player: AVPlayer! = nil
    var blurEffectView: UIVisualEffectView?
    var imageFromListeningViewController: UIImage?
    var finishdownload: Bool = false
    
    var inactiveQueue: DispatchQueue!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        songTitlelabel.text = selectlistenDetailModel?.title
        backgroundImage.image = UIImage(named: "background")
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImage.addSubview(blurEffectView!)
    
        if let image = imageFromListeningViewController {
            self.convertImageView.image = image
            self.convertImageView.layer.cornerRadius = self.convertImageView.frame.size.width / 2
            self.convertImageView.clipsToBounds = true
            self.convertImageView.layer.masksToBounds = true
            self.convertImageView.layer.borderWidth=1.5
            self.convertImageView.layer.borderColor = UIColor.white.cgColor
            self.convertImageView.layer.cornerRadius=self.convertImageView.bounds.width/2
        }
       
    
        startstopActivityIndicator.startAnimating()
        startstopButton.isHidden = true
        
        concurrentQueues()
        
        
    }
    
    func concurrentQueues() {
    
            let urlstring = self.selectlistenDetailModel?.mp3url
            let url = NSURL(string: urlstring!)
            print("the url = \(url!)")
            do {
                
                let playerItem = AVPlayerItem(url: url as! URL)
                
                self.player = try AVPlayer(playerItem:playerItem)
                self.finishdownload = true
                self.player.volume = 1.0
                self.player.automaticallyWaitsToMinimizeStalling = false
                self.startstopButton.isHidden = false
                self.startstopButton.setImage(UIImage(named: "playbutton" ), for: .normal)
                self.startstopActivityIndicator.stopAnimating()
                self.startstopActivityIndicator.removeFromSuperview()
             
            } catch let error as NSError {
                self.player = nil
                print(error.localizedDescription)
            } catch {
                print("AVAudioPlayer init failed")
            }
        
        }

    
    
    override func traitCollectionDidChange(_ previousTraitCollection:
        UITraitCollection?) {
        blurEffectView?.frame = view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player.pause()
    }
    
   

    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
  
    
  
    @IBAction func startAction(_ sender: UIButton) {
        
        if player?.rate == 0 {
                self.player!.volume = 1.0
                self.player!.play()
                self.startstopButton.isHidden = false
                self.startstopButton.setImage(UIImage(named: "playbutton" ), for: .normal)
                
        } else {
                player!.pause()
                self.startstopButton.setImage(UIImage(named: "stopbutton"), for: .normal)
        }
        
    }
    
   
    


  
  
    
}
