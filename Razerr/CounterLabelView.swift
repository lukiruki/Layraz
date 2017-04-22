//
//  CounterLabelView.swift
//  Razerr
//
//  Created by Aplikacje on 22/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

class CounterLabelView: UILabel {
    
    
    private var endValue: Int = 0
    
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
        
        self.backgroundColor = UIColor.clear
    }
    
}
