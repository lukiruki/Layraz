//
//  MainPodcastTableViewCell.swift
//  Razerr
//
//  Created by Aplikacje on 05/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

class MainPodcastTableViewCell: UITableViewCell {

    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var podcastDescriptionLabel: UILabel!
    @IBOutlet weak var podcastTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
