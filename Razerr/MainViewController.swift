//
//  MainViewController.swift
//  Razerr
//
//  Created by Aplikacje on 08/03/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func Logout(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "objectId")
        UserDefaults.standard.removeObject(forKey: "sessionToken")
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.synchronize()
        print("Uzytownik zostal wylogowany")
        
        let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controllerLogin: UIViewController = sb.instantiateViewController(withIdentifier: "firstView")
        self.present(controllerLogin, animated: true, completion: nil)

        
    }
    

}
