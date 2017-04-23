//
//  TargetView.swift
//  Razerr
//
//  Created by Aplikacje on 22/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

class TargetView: UIImageView {
    var letter: String
    var isMatched:Bool = false
    
    //this should never be called
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(letter:, sideLength:")
    }
    
    init(letter:String, sideLength:CGFloat) {
        self.letter = letter
        
        let image = UIImage(named: "emptyfield")!
        super.init(image:image)
        
        let scale = sideLength / image.size.width
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
    }
}

