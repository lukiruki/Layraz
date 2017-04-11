//
//  CounterLabelView.swift
//  Razerr
//
//  Created by Aplikacje on 21/03/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

class CounterLabelView: UILabel {
  
    
    private var endValue: Int = 0
    private var timer: Timer? = nil
    
    var value:Int = 0 {
       
        didSet {
            self.text = " \(value)"
        }
    }
    
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(font:frame:")
    }
    
    
    override init( frame:CGRect) {
        super.init(frame:frame)
        //self.font = font
        self.backgroundColor = UIColor.clear
    }
    
    func setValue(newValue:Int, duration:Float) {
        
        endValue = newValue
        
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
        // tutaj obliczamy interwal z jakim beda dodawane punkty, dzielac przez liczbe 
        // dzialania endValue - value czyli zdobytych lub utraconych pkt
        let deltaValue = abs(endValue - value)
        if (deltaValue != 0) {
            var interval = Double(duration / Float(deltaValue))
            if interval < 0.01 {
                interval = 0.01
            }
              timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(CounterLabelView.updateValue(timer:)), userInfo: nil, repeats: true)
    }
}
    
    func updateValue(timer:Timer) {
        
        if (endValue < value) {
            value -= 1
        } else {
            value += 1
        }
        
        if (endValue == value) {
            timer.invalidate()
            self.timer = nil
        }
}
}
