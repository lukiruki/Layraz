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
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var backgroundView: UIImageView!
    
    var blurEffectView: UIVisualEffectView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundView.image = UIImage(named: "background")
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundView.addSubview(blurEffectView!)
        
        usernameTextField.layer.cornerRadius = 8.0
        usernameTextField.layer.masksToBounds = true
        usernameTextField.layer.borderColor = UIColor( red: 255/255, green: 255/255, blue:255/255, alpha: 1.0 ).cgColor
        usernameTextField.layer.borderWidth = 2.0
        
        passwordTextField.layer.cornerRadius = 8.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.borderColor = UIColor( red: 255/255, green: 255/255, blue:255/255, alpha: 1.0 ).cgColor
        passwordTextField.layer.borderWidth = 2.0
        
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(MasterViewController.handleSwipeDownGesture(_:)))
        swipeDownGesture.direction = UISwipeGestureRecognizerDirection.down
        view.addGestureRecognizer(swipeDownGesture)
       
    }

    func handleSwipeDownGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        passwordTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppHelperOrientation.lockOrientation(.portrait)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        AppHelperOrientation.lockOrientation(.all)
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
            "X-Parse-Application-Id": "DvGa4MJJh3REJP3Q8tAqZDzuAbVPpHW7ZD5k5R25",
            "X-Parse-REST-API-Key": "Y0mspj596kgiy2QpVKO7ohfIoEF06fYw272wT1Xt",
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
