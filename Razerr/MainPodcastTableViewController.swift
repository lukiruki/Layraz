//
//  MainPodcastTableViewController.swift
//  Razerr
//
//  Created by Aplikacje on 04/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

class MainPodcastTableViewController: UITableViewController {

    
    var listenAllModel: [ListeningAllModel] = []
    
    var listeningApi = ListeningApi()
    
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
               
        self.listeningApi.getAllComedyListenData()
        
        let delayQueue = DispatchQueue(label: "com.appcoda.delayqueue", qos: .userInitiated)
        
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        let additionalTime: DispatchTimeInterval = .seconds(2)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.0)
        
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        
        
        delayQueue.asyncAfter(deadline: .now() + additionalTime) {
            print("drugie")
            self.listenAllModel = self.listeningApi.getAllData()
            for i in self.listenAllModel {
                print(i.name)
                print(i.description)
                print(i.imageString)
            }
            self.tableView.reloadData()
            
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listenAllModel.count
    
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Show", for: indexPath) as! MainPodcastTableViewCell

        
        let listenItem = listenAllModel[indexPath.row]
        
        cell.podcastTitleLabel.text = listenItem.name
        print(listenItem.name)
        cell.podcastDescriptionLabel.text = listenItem.description
        
        /////
        
        var image = UIImage()
        
        let imageUrl = URL(string: listenItem.imageString)
        
        let session = URLSession(configuration: .default)
        
        let downloadImage = session.dataTask(with: imageUrl!) { (data, response, error) in
            
            if let e = error {
                print("Error downloading image",e)
            } else {
                
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        DispatchQueue.main.async {
                            print("udalos ie pobrac")
                            image = UIImage(data: imageData)!
                            
                            cell.podcastImageView.image = image
                            cell.podcastImageView.layer.cornerRadius = 30.0
                            cell.podcastImageView.clipsToBounds = true
                        
                        }
                        
                    }else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
                
            }
        }
        
        downloadImage.resume()
        
        //////
        
        cell.backgroundColor = UIColor.clear

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
 

 

}
