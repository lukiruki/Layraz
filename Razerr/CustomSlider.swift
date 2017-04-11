//
//  CustomSlider.swift
//  Razerr
//
//  Created by Aplikacje on 09/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {
    
    var sliderIdentifier: Int! = 0
    
    required init() {
        super.init(frame: CGRect.zero)
        sliderIdentifier = 0
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sliderIdentifier = 0
    }
    
    
}
