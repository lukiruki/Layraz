//
//  NotificationsWordsModel.swift
//  Razerr
//
//  Created by Aplikacje on 10/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import Foundation

class NotificationsWordsModel: NSObject, NSCoding {
    

    var polishword: String = ""
    var englishword: String = ""
   
    
    init(polishword: String, englishword: String) {
        self.polishword = polishword
        self.englishword = englishword
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let polishword = aDecoder.decodeObject(forKey: "polishword") as! String
        let englishword = aDecoder.decodeObject(forKey: "englishword") as! String
        self.init(polishword: polishword, englishword: englishword)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(polishword, forKey: "polishword")
        aCoder.encode(englishword, forKey: "englishword")
    }
    
    
}
