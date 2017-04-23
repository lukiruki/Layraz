//
//  KindOfListeningCollectionViewController.swift
//  Razerr
//
//  Created by Aplikacje on 23/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "kindCell"

class KindOfListeningCollectionViewController: UICollectionViewController {

    var images: [String] = ["family_listening","film_listening","games_listening","health_listening","news_listening","smile_listening","sport_listening","technology_listening"]
    var names: [String] = ["Rodzina i przyjaciele","Filmy i bajki","Gry i hobby","Zdrowie i uroda","Wydarzenia i fakty","Rozrywka","Sport i rekreacja","Technologia i nauka "]
    
    var nameFromApi: [String] = ["AllKidsFamilyListen","AllFilmListen","AllGamesHobbiesListen","AllHealthListen","AllNewsListen","AllComedyListen","AllSportListen","AllTechnologyListen"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

  

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! KindOfListeningCollectionViewCell
    
        cell.labelKind.text = names[indexPath.row]
        cell.imageViewKind.image = UIImage(named: images[indexPath.row])
    
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendSegues" {
            if let indexPath = collectionView?.indexPathsForSelectedItems {
                let destinationController = segue.destination as! UINavigationController
                let targetDestination = destinationController.topViewController as! MainPodcastTableViewController
                targetDestination.kindofListeningfromKindController = nameFromApi[indexPath[0].row]
                collectionView?.deselectItem(at: indexPath[0], animated: false)
            }
            
            
        }
    }

    
}
