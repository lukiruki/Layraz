//
//  Spot.swift
//  Razerr
//
//  Created by Lukasz on 24.01.2017.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import Foundation

class Spot {
    
    let name: String
    let age :Int
    let description: String
    let id: Int?
    
    required init(aName: String, aAge: Int, aDescription: String, aId: Int?){
        
        name = aName
        age = aAge
        id = aId
        description = aDescription
    }
    
}
