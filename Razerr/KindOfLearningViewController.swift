//
//  KindOfLearningViewController.swift
//  Razerr
//
//  Created by Aplikacje on 04/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

class KindOfLearningViewController: UIViewController {

   
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = name {
            self.title = name
        }
    }

    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func listeningButton(_ sender: UIButton) {
    }
    @IBAction func readingButton(_ sender: UIButton) {
    }
    @IBAction func speakingButton(_ sender: UIButton) {
    }
    @IBAction func gamewritingButton(_ sender: UIButton) {
    }


}
