//
//  ListeningTableViewController.swift
//  Razerr
//
//  Created by Aplikacje on 23/03/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ListeningTableViewController: UITableViewController {

 
    var helperDetailModel: [AllListeningDetailModel] = []
    var listenDetailModel: [AllListeningDetailModel] = []
    
    var selectlistenDetailModel: AllListeningDetailModel?
    
    var objectid: String = ""
    var kindofListening: String = ""
    var image = UIImage()
    var tabAllImage: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.0)
        
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        getAllDetailDatatoListen()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return listenDetailModel.count
    }

    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListeningTableViewCell
        
        
        let listenItem = listenDetailModel[indexPath.row]
        
        cell.songTitleLabel.text = listenItem.title
        
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
                                    self.image = UIImage(data: imageData)!
        
                                    cell.coverImageView.image = self.image
                                    cell.coverImageView.layer.cornerRadius = 30.0
                                    cell.coverImageView.clipsToBounds = true
                                    self.tabAllImage.append(self.image)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPlayer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlayer" {
            
            let playerVC = segue.destination as! PlayerViewController
            let indexPath = tableView.indexPathForSelectedRow!
            selectlistenDetailModel = listenDetailModel[indexPath.row]
            playerVC.selectlistenDetailModel = selectlistenDetailModel
            playerVC.imageFromListeningViewController = tabAllImage[indexPath.row]
        
        }
    }
   
    
    func  getAllDetailDatatoListen() {
        let urlString = "https://parseapi.back4app.com/classes/HealthListen"
        
        
        let headers: HTTPHeaders = [
            "X-Parse-Application-Id": "DvGa4MJJh3REJP3Q8tAqZDzuAbVPpHW7ZD5k5R25",
            "X-Parse-REST-API-Key": "Y0mspj596kgiy2QpVKO7ohfIoEF06fYw272wT1Xt",
            "Accept": "application/json"
        ]
        
        
        let queue = DispatchQueue(label: "com.cnoon.manager-response-queue",qos: .userInitiated,attributes:.concurrent)
        
        
        Alamofire.request(urlString, method: .get,encoding: JSONEncoding.default, headers: headers).responseJSON(queue: queue, completionHandler: { response in
         
            switch response.result {
            case .success:
                
                
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    print(json)
                    print(response)
                    for index in 0..<7 {
                        var image = json["results"][index]["image"].stringValue
                        var mp3url = json["results"][index]["mp3url"].stringValue
                        var title = json["results"][index]["title"].stringValue
                        var objectid = json["results"][index]["objectid"]["objectId"].stringValue
                        var listen = AllListeningDetailModel(title: title, imageString: image, mp3url: mp3url,objectid: objectid)
                        self.helperDetailModel.append(listen)
                        
                    }
                    
                    DispatchQueue.main.async {
                        print("nasz object id wynosi",self.objectid)
                        for object in self.helperDetailModel as! [AllListeningDetailModel] {
                            if object.objectid == self.objectid {
                                self.listenDetailModel.append(object)
                            }
                        }
                        print("Lista w alamo", self.listenDetailModel.count)
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
