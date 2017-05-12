//
//  GameData.swift
//  Razerr
//
//  Created by Aplikacje on 21/03/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import Foundation
import UIKit

class GameData {
    
    var points: Int = 0 {
        didSet {
        
            points = max(points,0)
        }
    }
    
}
