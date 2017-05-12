//
//  HudView.swift
//  Razerr
//
//  Created by Aplikacje on 22/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

class HUDView: UIView {
    
    
    var gamePoints: CounterLabelView
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(frame:")
    }
    
    override init(frame:CGRect) {
        
        
        self.gamePoints = CounterLabelView(frame: CGRect(x: ScreenWidth, y: 30, width: 200, height: 70))
        gamePoints.textColor = UIColor(red: 0.38, green: 0.098, blue: 0.035, alpha: 1)
        gamePoints.font = UIFont(name: "Verdana-Bold", size: 15.0)
        gamePoints.value = 0
        
        super.init(frame:frame)
        
        self.addSubview(gamePoints)
        
        var pointsLabel = UILabel(frame: CGRect(x: ScreenWidth-100, y: 30, width: 140, height: 70))
        pointsLabel.backgroundColor = UIColor.clear
        //pointsLabel.font = FontHUD
        pointsLabel.font = UIFont(name: "Verdana-Bold", size: 15.0)
        pointsLabel.text = " Punkty:"
        self.addSubview(pointsLabel)
        
        // turn off interaction on HudView by what we will be able to take a TileView and drop on a TargetView
        self.isUserInteractionEnabled = false
    }
}
