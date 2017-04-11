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
    
    
    init(title: String, imageString: String, mp3url: String) {
        self.title = title
        self.imageString = imageString
        self.mp3url = mp3url
    }
    
    
}
