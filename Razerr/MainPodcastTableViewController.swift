//
//  MainPodcastTableViewController.swift
//  Razerr
//
//  Created by Aplikacje on 04/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainPodcastTableViewController: UITableViewController {

    private   let headers: HTTPHeaders = [
        "X-Parse-Application-Id": "DvGa4MJJh3REJP3Q8tAqZDzuAbVPpHW7ZD5k5R25",
        "X-Parse-REST-API-Key": "Y0mspj596kgiy2QpVKO7ohfIoEF06fYw272wT1Xt",
        "Accept": "application/json"
    ]
    
    var kindofListeningfromKindController: String = ""
    
    var listenAllModel: [ListeningAllModel] = []
    
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        let additionalTime: DispatchTimeInterval = .seconds(2)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.0)
        
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        getAllComedyListenData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listenAllModel.count
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendobjectidAndImage" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = segue.destination as! UINavigationController
                let viewController = controller.topViewController as! ListeningTableViewController
                viewController.objectid = listenAllModel[indexPath.row].objectid
                viewController.kindofListening = kindofListeningfromKindController
            }
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Show", for: indexPath) as! MainPodcastTableViewCell

        
        let listenItem = listenAllModel[indexPath.row]
        
        cell.podcastTitleLabel.text = listenItem.name
        print(listenItem.name)
        cell.podcastDescriptionLabel.text = listenItem.description
        
        let imageUrl = URL(string: listenItem.imageString)
        
        let session = URLSession(configuration: .default)
        
        cell.imageIndicator.startAnimating()
        
        let downloadImage = session.dataTask(with: imageUrl!) { (data, response, error) in
            
            if let e = error {
                print("Error downloading image",e)
            } else {
                
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        DispatchQueue.main.async {
                            print("udalos ie pobrac")
                            self.image = UIImage(data: imageData)!
                            
                            cell.podcastImageView.image = self.image
                            cell.podcastImageView.layer.cornerRadius = 30.0
                            cell.podcastImageView.clipsToBounds = true
                            cell.imageIndicator.stopAnimating()
                            cell.imageIndicator.removeFromSuperview()
                        
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
        
        cell.backgroundColor = UIColor.clear

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
 
    func  getAllComedyListenData() {
        let urlString = "https://parseapi.back4app.com/classes/\(kindofListeningfromKindController)"
        
        let queue = DispatchQueue(label: "com.cnoon.manager-response-queue",qos: .userInitiated,attributes:.concurrent)
        
        Alamofire.request(urlString, method: .get,encoding: JSONEncoding.default, headers: headers).responseJSON(queue: queue, completionHandler: { response in
            switch response.result {
            case .success:
                // print(response)
                
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    print(json)
                    for index in 0..<2 {
                        var title = json["results"][index]["title"].stringValue
                        var desc = json["results"][index]["description"].stringValue
                        var image = json["results"][index]["image"].stringValue
                        var objectid = json["results"][index]["objectId"].stringValue
                        var listen = ListeningAllModel(name: title, description: desc, imageString: image, objectid: objectid)
                        self.listenAllModel.append(listen)
                        
                    }
                    
                    
                    DispatchQueue.main.async {
                        print("Lista w alamo", self.listenAllModel.count)
                        self.tableView.reloadData()
                    }
                    
                }
                break
            case .failure(let error):
                
                print(error)
                break
            }
        }
      )
        
    }
 
}
