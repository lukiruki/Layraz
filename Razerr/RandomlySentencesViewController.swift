//
//  RandomlySentencesViewController.swift
//  Razerr
//
//  Created by Aplikacje on 04/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RandomlySentencesViewController: UIViewController {

    
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    private let controller:GameController
    var gameView: UIView!
    var increaseLevel: Int = 1
    
    var tabSentences: [Sentences] = []
    var increaseTabSentences: Int = 0
    var yourcheckString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishLabel.isHidden = true
        backButton.isHidden = true
        
        getSentencesForGame()
        
        
        gameView = UIView(frame: CGRect(x: 0,  y: 0, width: ScreenWidth + 400, height: ScreenHeight + 400))
        self.view.addSubview(gameView)
        
        let hudView = HUDView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(hudView)
        controller.hud = hudView
        
        AppHelperOrientation.lockOrientation(.landscapeLeft)
        
        NotificationCenter.default.addObserver(self, selector: #selector(RandomlySentencesViewController.checkLevelForGameController), name: NSNotification.Name(rawValue: "addlevel"), object: nil)
        
        
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppHelperOrientation.lockOrientation(.landscapeLeft)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        AppHelperOrientation.lockOrientation(.all)
    }
    
    required init(coder aDecoder: NSCoder) {
        controller = GameController()
        super.init(coder: aDecoder)!
    }
    
    func checkLevelForGameController() {
        if controller.amountLevel == 2 {
            controller.clearBoard()
            gameView.removeFromSuperview()
            finishLabel.isHidden = false
            backButton.isHidden = false
            
        } else {
            controller.clearBoard()
            controller.sentence = tabSentences[increaseTabSentences + 1]
            controller.dealRandomAnagram()

        }
    }
    
    func getSentencesForGame() {
        let urlString = "https://parseapi.back4app.com/classes/\(yourcheckString)"
        
        let queue = DispatchQueue(label: "com.cnoon.manager-response-queue",qos: .userInitiated,attributes:.concurrent)
        
        let headers: HTTPHeaders = [
            "X-Parse-Application-Id": "DvGa4MJJh3REJP3Q8tAqZDzuAbVPpHW7ZD5k5R25",
            "X-Parse-REST-API-Key": "Y0mspj596kgiy2QpVKO7ohfIoEF06fYw272wT1Xt",
            "Accept": "application/json"
        ]
        
        Alamofire.request(urlString, method: .get,encoding: JSONEncoding.default, headers: headers).responseJSON(queue: queue, completionHandler: { response in
            switch response.result {
            case .success:
                
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    print(value)
                    for index in 0..<2 {
                        var rightSentences = json["results"][index]["englishSentence"].stringValue
                        var falseSentences = json["results"][index]["mixWords"].stringValue
                        var sentence = Sentences(rightSentences: rightSentences, falseSentences: falseSentences)
                        self.tabSentences.append(sentence)
                        
                    }
                    DispatchQueue.main.async {

                        if self.tabSentences.count != 0 {
                            print("Size arrays' tabsentence",self.tabSentences.count)
                            
                            
                            self.controller.sentence = self.tabSentences[self.increaseTabSentences]
                        }
           
                        self.controller.gameView = self.gameView
                        self.controller.dealRandomAnagram()
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
