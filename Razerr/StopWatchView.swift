//
//  StopWatchView.swift
//  Razerr
//
//  Created by Aplikacje on 21/03/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import Foundation
import UIKit

class StopwatchView: UILabel {
    
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(frame:")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
       // self.font = UIFont(name:"comic andy", size: 62.0)!
    }
    
    func setSeconds(seconds:Int) {
        self.text = String(format: " %02i : %02i", seconds/60, seconds % 60)
    }
}
