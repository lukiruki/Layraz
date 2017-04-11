//
//  MainReadingCollectionViewCell.swift
//  Razerr
//
//  Created by Aplikacje on 08/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

class MainReadingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var readingImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.readingImage.layer.masksToBounds = true
        self.readingImage.layer.cornerRadius  = CGFloat(roundf(Float(self.readingImage.frame.size.width/2.0)))
    }
}
