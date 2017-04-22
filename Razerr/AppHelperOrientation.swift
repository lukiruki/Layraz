//
//  AppHelperOrientation.swift
//  Razerr
//
//  Created by Aplikacje on 22/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import Foundation
import UIKit

struct AppHelperOrientation {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
 

}
