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
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var songTitlelabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var shuffle: UISwitch!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var startstopActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var startstopButton: UIButton!
    
    var selectlistenDetailModel: AllListeningDetailModel?
    var player: AVPlayer!
    var updater : CADisplayLink! = nil
    var blurEffectView: UIVisualEffectView?
    var time: Float = 0.0
    var durationone: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        songTitlelabel.text = selectlistenDetailModel?.title
        backgroundImage.image = UIImage(named: "background")
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImage.addSubview(blurEffectView!)
        
        var image = UIImage()
        activityIndicator.startAnimating()
        
        startstopButton.isHidden = true
        let imageUrl = URL(string: (selectlistenDetailModel?.imageString)!)
        
        let session = URLSession(configuration: .default)
        
        let downloadImage = session.dataTask(with: imageUrl!) { (data, response, error) in
            
            if let e = error {
                print("Error downloading image",e)
            } else {
                
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        DispatchQueue.main.async {
                            print("udalos ie pobrac")
                            self.activityIndicator.stopAnimating()
                            image = UIImage(data: imageData)!
                            
                            self.convertImageView.image = image
                            self.convertImageView.layer.cornerRadius = self.convertImageView.frame.size.width / 2
                            self.convertImageView.clipsToBounds = true
                            self.convertImageView.layer.masksToBounds = true
                            self.convertImageView.layer.borderWidth=1.5
                            self.convertImageView.layer.borderColor = UIColor.white.cgColor
                            self.convertImageView.layer.cornerRadius=self.convertImageView.bounds.width/2
                        
                        }
                        
                    }else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
                
            }
        }
        
        downloadImage.resume()
        
        let urlstring = selectlistenDetailModel?.mp3url
        let url = NSURL(string: urlstring!)
        print("the url = \(url!)")
        do {
            
            let playerItem = AVPlayerItem(url: url as! URL)
            
            self.player = try AVPlayer(playerItem:playerItem)
            player!.volume = 1.0
            
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
         player!.play()
            self.startstopButton.setImage(UIImage(named: "playbutton" ), for: .normal)
           
        } else {
            player!.pause()
            self.startstopButton.setImage(UIImage(named: "stopbutton"), for: .normal)
           
        }
    }
    


  
  
    
}
