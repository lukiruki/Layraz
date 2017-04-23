//
//  AllListenDetailModel.swift
//  Razerr
//
//  Created by Aplikacje on 06/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import Foundation


class AllListeningDetailModel {
    
    var mp3url: String = ""
    var title: String = ""
    var imageString: String = ""
    var objectid: String = ""
    
    init(title: String, imageString: String, mp3url: String, objectid: String) {
        self.title = title
        self.imageString = imageString
        self.mp3url = mp3url
        self.objectid = objectid
    }
    
    
}
