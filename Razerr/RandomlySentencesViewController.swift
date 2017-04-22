//
//  RandomlySentencesViewController.swift
//  Razerr
//
//  Created by Aplikacje on 04/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

class RandomlySentencesViewController: UIViewController {

    
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    private let controller:GameController
    var gameView: UIView!
    var level: Level!
    var increaseLevel: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishLabel.isHidden = true
        backButton.isHidden = true
        
        level = Level(levelNumber: increaseLevel)
        
        gameView = UIView(frame: CGRect(x: 0,  y: 0, width: ScreenWidth + 400, height: ScreenHeight + 400))
        self.view.addSubview(gameView)
        
        let hudView = HUDView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(hudView)
        controller.hud = hudView
        
        controller.gameView = gameView
        
        controller.level = level
        controller.dealRandomAnagram()
        
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
            level = Level(levelNumber: increaseLevel + 1)
            controller.level = level
            controller.dealRandomAnagram()

        }
    }
    
   
    
   
}
