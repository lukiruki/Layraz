//
//  ListeningTableViewController.swift
//  Razerr
//
//  Created by Aplikacje on 23/03/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

class ListeningTableViewController: UITableViewController {

    var apiDetail = ListeningDetailApi()
    
    var listenDetailModel: [AllListeningDetailModel] = []
    
    var selectlistenDetailModel: AllListeningDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.0)
        
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
       apiDetail.getAllComedyListenData()
        
        
        let delayQueue = DispatchQueue(label: "com.appcoda.delayqueue", qos: .userInitiated)
        
        
        let additionalTime: DispatchTimeInterval = .seconds(2)
        
        delayQueue.asyncAfter(deadline: .now() + additionalTime) {
            self.listenDetailModel = self.apiDetail.getAllData()
            self.tableView.reloadData()
            
        }
        
       
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return listenDetailModel.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListeningTableViewCell
        
        
        let listenItem = listenDetailModel[indexPath.row]
        
        cell.songTitleLabel.text = listenItem.title
        
        /////
        
//        var image = UIImage()
//        
//        let imageUrl = URL(string: listenItem.imageString)
//        print(imageUrl)
//        let session = URLSession(configuration: .default)
//        
//        let downloadImage = session.dataTask(with: imageUrl!) { (data, response, error) in
//            
//            if let e = error {
//                print("Error downloading image",e)
//            } else {
//                
//                if let res = response as? HTTPURLResponse {
//                    print("Downloaded cat picture with response code \(res.statusCode)")
//                    if let imageData = data {
//                        DispatchQueue.main.async {
//                            print("udalos ie pobrac")
//                            image = UIImage(data: imageData)!
//                            
//                            cell.coverImageView.image = image
//                            cell.coverImageView.layer.cornerRadius = 30.0
//                            cell.coverImageView.clipsToBounds = true
//                        }
//                        
//                    }else {
//                        print("Couldn't get image: Image is nil")
//                    }
//                } else {
//                    print("Couldn't get response code for some reason")
//                }
//                
//            }
//        }
//        
//        downloadImage.resume()
        
    
        
         cell.backgroundColor = UIColor.clear
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPlayer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlayer" {
            
            let playerVC = segue.destination as! PlayerViewController
            let indexPath = tableView.indexPathForSelectedRow!
            selectlistenDetailModel = listenDetailModel[indexPath.row]
            playerVC.selectlistenDetailModel = selectlistenDetailModel
           // playerVC.trackId = indexPath.row
        }
    }
   

}
