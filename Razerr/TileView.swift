//
//  TileView.swift
//  Razerr
//
//  Created by Aplikacje on 21/03/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import Foundation
import UIKit

protocol TileDragDelegateProtocol {
    func tileView(tileView: TileView, didDragToPoint: CGPoint)
}

class TileView: UIImageView {

    // zapisujemy obecna transformacje obiektu Image tzn jest to poczatkowa wielkosc jaka posiada obrazek, ktory pozniej bedzie powiekszony przy przeciaganiu
    private var tempTransform: CGAffineTransform = CGAffineTransform.identity
    
    var letter: Character
    
    private var xOffset: CGFloat = 0.0
    private var yOffset: CGFloat = 0.0
    
    var isMatched: Bool = false
    
    var dragDelegate: TileDragDelegateProtocol?
    
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(letter:, sideLength:")
    }

    init(letter: Character, sideLength: CGFloat) {
    
        
        self.letter = letter
        
        let image = UIImage(named: "tile")!
        
        super.init(image:image)
    
        let scale = sideLength / image.size.width
        
        self.frame = CGRect(x: 0, y: 0, width: image.size.width * scale, height: image.size.height * scale)
        
        let letterLabel = UILabel(frame: self.bounds)
        letterLabel.textAlignment = NSTextAlignment.center
        letterLabel.textColor = UIColor.white
        letterLabel.backgroundColor = UIColor.clear
        letterLabel.text = String(letter).uppercased()
        letterLabel.font = UIFont(name: "Verdana-Bold", size: 78.0 * scale)
        self.addSubview(letterLabel)
        
        self.isUserInteractionEnabled = true
        
        // ustawiamy cien dla obrazka
        self.layer.shadowColor = UIColor.black.cgColor
        // cien jak narazie jest niewidoczny ale bedzie w touchMoved i zniknie w touchEnded
        self.layer.shadowOpacity = 0
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.shadowRadius = 15.0
        // ustawiamy masks na false przez co layer utworzy nam cien nawet poza granicami obrazka
        self.layer.masksToBounds = false
        
        // ustawiamy ksztalt cienia
        let path = UIBezierPath(rect: self.bounds)
        self.layer.shadowPath = path.cgPath
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as? UITouch! {
            let point = touch.location(in: self.superview)
            xOffset = point.x - self.center.x
            yOffset = point.y - self.center.y
            self.layer.shadowOpacity = 0.8
            
            
            // zapisujemy wielkosc obrazka i pozniej zwiekszamy
            
            tempTransform = self.transform
            self.transform = self.transform.scaledBy(x: 1.2, y: 1.2)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as? UITouch! {
            let point = touch.location(in: self.superview)
            self.center = CGPoint(x: point.x - xOffset,y: point.y - yOffset)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesMoved(touches, with: event)
        dragDelegate?.tileView(tileView: self, didDragToPoint: self.center)
        self.layer.shadowOpacity = 0.0
        self.transform = tempTransform
    }
    
//    iOS calls touchesCancelled(_:withEvent:) in certain special situations, like when the app receives a low memory warning or if a notification brings up a modal alert. Your method will ensure that the tile’s display is properly restored.
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = tempTransform
        self.layer.shadowOpacity = 0.0
    }
    
    func randomize() {
        //1
        //set random rotation of the tile
        //anywhere between -0.2 and 0.3 radians
        let rotation = CGFloat(randomNumber(minX:0, maxX:50)) / 100.0 - 0.2
        self.transform = CGAffineTransform(rotationAngle: rotation)
        
        //2
        //move randomly upwards
        let yOffset = CGFloat(randomNumber(minX: 0, maxX: 10) - 10)
        self.center = CGPoint(x: self.center.x, y: self.center.y + yOffset)
    }
    

}
