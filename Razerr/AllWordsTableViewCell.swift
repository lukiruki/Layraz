//
//  AllWordsTableViewCell.swift
//  Razerr
//
//  Created by Aplikacje on 09/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

protocol ButtonCellDelegate {
    func cellTapped(_ cell: AllWordsTableViewCell)
}

class AllWordsTableViewCell: UITableViewCell {

    var buttonDelegate: ButtonCellDelegate?
    
    @IBOutlet weak var polishWordLabel: UILabel!
    @IBOutlet weak var englishWordLabel: UILabel!
    @IBOutlet weak var sentenceEnglish: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func soundButton(_ sender: UIButton) {
        if let delegate = buttonDelegate {
            delegate.cellTapped(self)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
