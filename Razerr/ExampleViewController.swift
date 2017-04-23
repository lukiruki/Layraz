//
//  ExampleViewController.swift
//  Razerr
//
//  Created by Aplikacje on 23/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {

    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addProgressAnimation(view: view1, key: "v1", value: 0.6,duration: 3)
        addProgressAnimation(view: view2, key: "v2", value: 0.5,duration: 4)
        addProgressAnimation(view: view3, key: "v3", value: 0.7,duration: 5)
        addProgressAnimation(view: view4, key: "v4", value: 0.8,duration: 6)
     
    }
    
    
    func addProgressAnimation(view: UIView, key: String, value: Float, duration: Int) {
        
        let circle = view
        
        var progressCircle = CAShapeLayer()
        
        let circlePath = UIBezierPath(ovalIn: (circle.bounds))
        
        progressCircle = CAShapeLayer ()
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = UIColor(red: 216.0/255.0, green: 74.0/255.0, blue: 32.0/255.0, alpha: 1.0).cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = 10.0
        
        circle.layer.addSublayer(progressCircle)
        
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = value
        animation.duration = CFTimeInterval(duration)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        progressCircle.add(animation, forKey: key)
        self.view.addSubview(circle)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        circle.addGestureRecognizer(gesture)
    }

    
    
    
    func someAction(_ sender:UITapGestureRecognizer){
        if view1.tag == (sender.view)?.tag {
            gotoRandomlyControllerwithchooseString(yourchoose: "eWritingPastSimple")
        } else if view2.tag == (sender.view)?.tag {
            gotoRandomlyControllerwithchooseString(yourchoose: "eWritingPastContinuous")
        } else if view3.tag == (sender.view)?.tag {
            gotoRandomlyControllerwithchooseString(yourchoose: "eWritingPresentContinuous")
        } else if view4.tag == (sender.view)?.tag {
            gotoRandomlyControllerwithchooseString(yourchoose: "eWritingPresentSimple")
        }
    }

    func gotoRandomlyControllerwithchooseString(yourchoose: String) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "randomlyViewController") as! RandomlySentencesViewController
        
        nextViewController.yourcheckString = yourchoose
        
        self.present(nextViewController, animated:true, completion:nil)
    }
    
 

}
