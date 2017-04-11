//
//  SentenceViewController.swift
//  Razerr
//
//  Created by Aplikacje on 15/03/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import Foundation
import UIKit

class SentenceViewController: UIViewController {
    
    private let controller:GameController

    override func viewDidLoad() {
        super.viewDidLoad()
    
        var level1 = Level(levelNumber: 1)
        
        let gameView = UIView(frame: CGRect(x: 0,  y: 0, width: ScreenWidth, height: ScreenHeight))
            self.view.addSubview(gameView)
        
        let hudView = HUDView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(hudView)
        controller.hud = hudView
        
        controller.gameView = gameView
        
        controller.level = level1
        controller.dealRandomAnagram()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        controller = GameController()
        super.init(coder: aDecoder)!
    }

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

//override var prefersStatusBarHidden : Bool {
//    return true
//}

}
