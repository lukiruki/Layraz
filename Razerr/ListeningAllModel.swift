//
//  ListeningAllModel.swift
//  Razerr
//
//  Created by Aplikacje on 05/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import Foundation


class ListeningAllModel {
    
    var name: String = ""
    var description: String = ""
    var imageString: String = ""
    var objectid: String = ""
    
    init(name: String, description: String, imageString: String, objectid: String) {
        self.name = name
        self.description = description
        self.imageString = imageString
        self.objectid = objectid
    }
    
    
}
