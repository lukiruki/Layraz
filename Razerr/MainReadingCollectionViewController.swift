//
//  MainReadingCollectionViewController.swift
//  Razerr
//
//  Created by Aplikacje on 04/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainReadingCollectionViewController: UICollectionViewController {

    var names: [String] = ["Człowiek","Dom","Szkoła","Rodzina i przyjaciele","Żywienie","Zakupy","Podróżowanie","Kultura","Sport","Zdrowie","Nauka","Przyroda","Społeczeństwo"]
    var images: [String] = ["human","home","school","family","food","shop","travel","culture","sport","health","technology","nature","society"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
       
        collectionView?.layer.cornerRadius = 5.0
        collectionView?.clipsToBounds = true
       
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return names.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainReadingCollectionViewCell
    
        let name = names[indexPath.row]
        let icon = images[indexPath.row]
        cell.readingLabel.text = name
        cell.readingImage.image = UIImage(named: icon)
        
        cell.backgroundColor = UIColor.clear
        return cell
    }

    
    

}
