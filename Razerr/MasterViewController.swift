//
//  MasterViewController.swift
//  Razerr
//
//  Created by Lukasz on 24.01.2017.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MasterViewController: UIViewController {

    var spots = [Spot]()
    
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//            getController()
//            updateController()
       
    }

    @IBAction func LoginButton(_ sender: UIButton) {
        
        if(usernameTextField.text == nil || (usernameTextField.text?.isEmpty)!) {
            print("Username required")
            return
        }
        
        if(passwordTextField.text == nil || (passwordTextField.text?.isEmpty)!) {
            print("Password required")
            return
        }
        
        let headers: HTTPHeaders = [
            "X-Parse-Application-Id": "pb0CI3Y8T9cDcV9SXszZ5KZsFhlPmFNQPjVQz19X",
            "X-Parse-REST-API-Key": "OhBTU6qlpvotBRLuc1qWfiWs9YPugDA4tuSaSZBD",
            "X-Parse-Revocable-Session" : "1",
            "Accept": "application/json"
        ]
        
        let params = ["username": usernameTextField.text!,
                      "password": passwordTextField.text!,
                      ] as [String : Any]
        
        let apiMethod = "https://parseapi.back4app.com/login"
        
        Alamofire.request(apiMethod, method: .get, parameters: params, encoding: URLEncoding(), headers: headers).responseJSON { (response) in
          
           
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling GET on /posts/1")
                print(response.result.error!)
                return
            }
            
            if let value: AnyObject = response.result.value as AnyObject? {
                // handle the results as JSON, without a bunch of nested if loops
                let post = JSON(value)
                print("The User is: " + post.description)
        
                if let username = post["username"].string {
                     print("My name issssss" + username)
                    
                    UserDefaults.standard.set(post["objectId"].stringValue, forKey: "objectId")
                    UserDefaults.standard.set(post["sessionToken"].stringValue, forKey: "sessionToken")
                    UserDefaults.standard.set(post["username"].stringValue, forKey: "username")
                    
                    UserDefaults.standard.synchronize()
                 
                    
                    let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let controllerLogin: UIViewController = sb.instantiateViewController(withIdentifier: "newView")
                    self.present(controllerLogin, animated: true, completion: nil)
                } else {
                    print("wrong username & password")
                }
               
            // Yeah! Hand response
            
            }
        }
        
    
    }
    
    
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        
        if(usernameTextField.text == nil || (usernameTextField.text?.isEmpty)!) {
            print("Username required")
            return
        }
       
        if(passwordTextField.text == nil || (passwordTextField.text?.isEmpty)!) {
            print("Password required")
            return
        }
        
        let headers: HTTPHeaders = [
            "X-Parse-Application-Id": "pb0CI3Y8T9cDcV9SXszZ5KZsFhlPmFNQPjVQz19X",
            "X-Parse-REST-API-Key": "OhBTU6qlpvotBRLuc1qWfiWs9YPugDA4tuSaSZBD",
            "Accept": "application/json"
        ]
        
        let params = ["username": usernameTextField.text!,
                      "password": passwordTextField.text!,
                      ] as [String : Any]
        
        let apiMethod = "https://parseapi.back4app.com/users"
        
        Alamofire.request(apiMethod, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseString { (response) in
            
            print(response);
            
            let alertController = UIAlertController(title: "REGISTRATION SUCCESSFUL!", message: nil, preferredStyle: .alert);
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
            
        
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
   
    func getController() {
        
        let urlString = "https://parseapi.back4app.com/classes/Spot"
        
        let headers: HTTPHeaders = [
            "X-Parse-Application-Id": "pb0CI3Y8T9cDcV9SXszZ5KZsFhlPmFNQPjVQz19X",
            "X-Parse-REST-API-Key": "OhBTU6qlpvotBRLuc1qWfiWs9YPugDA4tuSaSZBD",
            "Accept": "application/json"
        ]
        
        Alamofire.request(urlString, method: .get,encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
        
    }
    
    func updateController() {
        
        let urlString = "https://parseapi.back4app.com/classes/Spot"
        
        let headers: HTTPHeaders = [
            "X-Parse-Application-Id": "pb0CI3Y8T9cDcV9SXszZ5KZsFhlPmFNQPjVQz19X",
            "X-Parse-REST-API-Key": "OhBTU6qlpvotBRLuc1qWfiWs9YPugDA4tuSaSZBD",
            "Accept": "application/json"
        ]
        let parameters: Parameters = ["Age": "16","Name":"Ola","Description":"Moj nowy obiekt"]
        
        Alamofire.request(urlString, method: .post,parameters: parameters,encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
        
        
    }
    
    
    

    
}
