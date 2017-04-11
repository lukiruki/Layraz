//
//  ListeningApi.swift
//  Razerr
//
//  Created by Aplikacje on 05/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



class ListeningApi {

    private   let headers: HTTPHeaders = [
        "X-Parse-Application-Id": "DvGa4MJJh3REJP3Q8tAqZDzuAbVPpHW7ZD5k5R25",
        "X-Parse-REST-API-Key": "Y0mspj596kgiy2QpVKO7ohfIoEF06fYw272wT1Xt",
        "Accept": "application/json"
    ]
    
    var listenAllModel: [ListeningAllModel] = []
    var allWordsForNotifications: [NotificationsWordsModel] = []
    
    
    func  getAllComedyListenData() {
        let urlString = "https://parseapi.back4app.com/classes/AllComedyListen"
        
            Alamofire.request(urlString, method: .get,encoding: JSONEncoding.default, headers: headers).responseJSON {
                response in
                switch response.result {
                case .success:
                    // print(response)
                    
                    if let value = response.result.value {
                        let json = JSON(value)
                        
                        
                        for index in 0..<2 {
                            var title = json["results"][index]["title"].stringValue
                            var desc = json["results"][index]["description"].stringValue
                            var image = json["results"][index]["image"].stringValue
                            
                            var listen = ListeningAllModel(name: title, description: desc, imageString: image)
                            self.listenAllModel.append(listen)
                            
                        }
                        
                        print("Lista w alamo", self.listenAllModel.count)
                        
                        
                    }
                    break
                case .failure(let error):
                    
                    print(error)
                    break
                }
            }
          print("Lista poza alamo", self.listenAllModel.count)
        
    }
    
    
    func  getAllWordsNotifications() -> [NotificationsWordsModel] {
        let urlString = "https://parseapi.back4app.com/classes/eWords"
        
        let queue = DispatchQueue(label: "com.cnoon.manager-response-queue",qos: .userInitiated,attributes:.concurrent)
        
        Alamofire.request(urlString, method: .get,encoding: JSONEncoding.default, headers: headers).responseJSON(queue: queue, completionHandler: { response in
            switch response.result {
            case .success:
                // print(response)
                
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    print(value)
                    for index in 0..<20 {
                        var polishword = json["results"][index]["polishword"].stringValue
                        var englishWord = json["results"][index]["englishword"].stringValue
                        var word = NotificationsWordsModel(polishword: polishword, englishword: englishWord)
                        self.allWordsForNotifications.append(word)
                        
                    }
                    DispatchQueue.main.async {
                        print("Lista w alamo", self.listenAllModel.count)

                    }
                    
                    
                }
                break
            case .failure(let error):
                
                print(error)
                break
            }
            
        }
      )
        
        return allWordsForNotifications 
    }
    
    func getAllData() -> [ListeningAllModel] {
        return listenAllModel
    }
    
   

}
