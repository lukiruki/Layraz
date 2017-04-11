//
//  FIrstCollectionViewController.swift
//  Razerr
//
//  Created by Aplikacje on 04/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FIrstCollectionViewController: UICollectionViewController {

    private var names: [FirstStruct] = [
        FirstStruct(name: "Początkujący", imagename: "begginer", isSelected: false),
        FirstStruct(name: "Średniozaawansowany", imagename: "intermeddiate", isSelected: false),
        FirstStruct(name: "Zaawansowany", imagename: "expert", isSelected: false),
        FirstStruct(name: "Powiadomienia", imagename: "gamewriting", isSelected: false)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return names.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FirstCollectionViewCell
    
        let icon = names[indexPath.row]
        cell.iconImageView.image = UIImage(named: icon.imagename)
        cell.iconNameLabel.text = icon.name
        cell.backgroundView = (icon.isSelected) ? UIImageView(image: UIImage(named: "feature-bg")) : nil
        
        
        return cell
    }

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = collectionView?.indexPathsForSelectedItems {
//                let name = names[indexPath[0].row]
//                    let destinationController = segue.destination as! SecondCollectionViewController
//                    destinationController.name = name.name
//                    collectionView?.deselectItem(at: indexPath[0], animated: false)
//            }
//            
//            
//        }
//    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        names[indexPath.row].isSelected = true

    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        names[indexPath.row].isSelected = false
    }
    
}
