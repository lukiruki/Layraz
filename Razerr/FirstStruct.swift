//
//  FirstStruct.swift
//  Razerr
//
//  Created by Aplikacje on 04/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import Foundation


struct FirstStruct {
    
    var name: String = ""
    var imagename: String = ""
    var isSelected: Bool = false
    
    
    init(name: String, imagename: String, isSelected: Bool) {
        self.name = name
        self.imagename = imagename
        self.isSelected = isSelected
    }
    
    
}
