//
//  RegistrationViewController.swift
//  Razerr
//
//  Created by Aplikacje on 13/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegistrationViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.layer.cornerRadius = 8.0
        usernameTextField.layer.masksToBounds = true
        usernameTextField.layer.borderColor = UIColor( red: 255/255, green: 255/255, blue:255/255, alpha: 1.0 ).cgColor
        usernameTextField.layer.borderWidth = 2.0
        
        passwordTextField.layer.cornerRadius = 8.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.borderColor = UIColor( red: 255/255, green: 255/255, blue:255/255, alpha: 1.0 ).cgColor
        passwordTextField.layer.borderWidth = 2.0
        
        emailTextField.layer.cornerRadius = 8.0
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.borderColor = UIColor( red: 255/255, green: 255/255, blue:255/255, alpha: 1.0 ).cgColor
        emailTextField.layer.borderWidth = 2.0
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(MasterViewController.handleSwipeDownGesture(_:)))
        swipeDownGesture.direction = UISwipeGestureRecognizerDirection.down
        view.addGestureRecognizer(swipeDownGesture)
    }
    
    func handleSwipeDownGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        passwordTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
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
            "X-Parse-Application-Id": "DvGa4MJJh3REJP3Q8tAqZDzuAbVPpHW7ZD5k5R25",
            "X-Parse-REST-API-Key": "Y0mspj596kgiy2QpVKO7ohfIoEF06fYw272wT1Xt",
            "Accept": "application/json"
        ]
        
        let params = ["username": usernameTextField.text!,
                      "password": passwordTextField.text!,
                      "email": emailTextField.text!
                      ] as [String : Any]
        
        let apiMethod = "https://parseapi.back4app.com/users"
        
        Alamofire.request(apiMethod, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseString { (response) in
        switch response.result {
           case .success:
            print(response);
            
            let alertController = UIAlertController(title: "Pomyślnie zarejestrowano :)", message: nil, preferredStyle: .alert);
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: self.goToMainController));
            
            self.present(alertController, animated: true, completion: nil)
            break
            case .failure(let error):
            
                let alertController = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert);
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil ));
                
                self.present(alertController, animated: true, completion: nil)

            break
            }
            
            
        }
            
        
    }
 
    
    func goToMainController(action: UIAlertAction) {
        self.dismiss(animated: true, completion: nil)
    }

}
