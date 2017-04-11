//
//  ListeningDetailApi.swift
//  Razerr
//
//  Created by Aplikacje on 06/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ListeningDetailApi {
    
    
    var listenAllModel: [AllListeningDetailModel] = []
    
    
    
    func  getAllComedyListenData() {
        let urlString = "https://parseapi.back4app.com/classes/ComedyListen"
        
        
        let headers: HTTPHeaders = [
            "X-Parse-Application-Id": "DvGa4MJJh3REJP3Q8tAqZDzuAbVPpHW7ZD5k5R25",
            "X-Parse-REST-API-Key": "Y0mspj596kgiy2QpVKO7ohfIoEF06fYw272wT1Xt",
            "Accept": "application/json"
        ]
        
        
        
        
        
        Alamofire.request(urlString, method: .get,encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            switch response.result {
            case .success:
                // print(response)
                
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    print(response)
                    for index in 0..<7 {
                        var image = json["results"][index]["image"].stringValue
                        var mp3url = json["results"][index]["mp3url"].stringValue
                        var title = json["results"][index]["title"].stringValue
                        
                        var listen = AllListeningDetailModel(title: title, imageString: image, mp3url: mp3url)
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
    
    func getAllData() -> [AllListeningDetailModel] {
        return listenAllModel
    }
    
}
