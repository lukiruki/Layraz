//
//  Level.swift
//  Anagrams
//
//  Created by Aplikacje on 15/03/17.
//  Copyright © 2017 Caroline. All rights reserved.
//

import Foundation
import UIKit

struct Level {
    
    let pointsPerTitle: Int
    let timeToSolve: Int
    let anagrams: [NSArray]
    
    init(levelNumber: Int) {
        
        let path = Bundle.main.path(forResource: "level1", ofType: "plist")
        
        
        let levelDictionary = NSDictionary(contentsOfFile: path!) as! [String:AnyObject]
        
        assert(levelDictionary != nil, "Level configuration file not found")
        
        self.pointsPerTitle = levelDictionary["pointsPerTile"] as! Int
        self.timeToSolve = levelDictionary["timeToSolve"] as! Int
        self.anagrams = levelDictionary["anagrams"] as! [NSArray]
        
        print(anagrams)
        
    }
    
    
    
}


