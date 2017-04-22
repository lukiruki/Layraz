//
//  GameController.swift
//  Razerr
//
//  Created by Aplikacje on 16/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import Foundation
import UIKit

import Foundation
import UIKit

class GameController {
    
    var gameView: UIView!
    var level: Level!
    var hud: HUDView!
    
    private var secondsLeft: Int = 0
    private var timer: Timer?
    
    fileprivate var data = GameData()
    
    private var tiles = [TileView]()
    fileprivate var targets = [TargetView]()
    
    
    var amountLevel: Int = 0
    
    init() {
        
    }
    
    
    
    func dealRandomAnagram () {
        
        assert(level.anagrams.count > 0, "no level loaded")
        
        let randomIndex = randomNumber(minX:0, maxX:UInt32(level.anagrams.count-1))
        let anagramPair = level.anagrams[randomIndex]
        
        let anagram1 = anagramPair[0] as! String
        let anagram2 = anagramPair[1] as! String
        
        
        let anagram1length = anagram1.characters.count
        let anagram2length = anagram2.characters.count
        
        print("phrase1[\(anagram1length)]: \(anagram1)")
        print("phrase2[\(anagram2length)]: \(anagram2)")
        
        
        // obliczamy wielkosc tile
        let tileSide = ceil(ScreenWidth * 0.9 / CGFloat(max(anagram1length, anagram2length))) - TileMargin
        
        // wyszukujemy polozenie x lewe pierwszego tile
        var xOffset = (ScreenWidth - CGFloat(10.0) * (tileSide + TileMargin)) / 2.0
        
        // centrujemy nasza pozycje dla tile, ktora ma wartosc od lewego x wiec trzeba to wycentrowac
        xOffset += tileSide / 2.0
        
        //initialize target list
        targets = []
        
        let tab2 = anagram2.components(separatedBy: " ")
        
        print(tab2)
        for (index, letter) in tab2.enumerated() {
            if letter != " " {
                let target = TargetView(letter: letter, sideLength: tileSide)
                target.center = CGPoint(x: xOffset + CGFloat(index)*(tileSide + 120), y: ScreenHeight/5)
                
                targets.append(target)
                gameView.addSubview(target)
                
            }
        }
        
        tiles = []
        
        let tab1 = anagram1.components(separatedBy: " ")
          print(tab1)
        for (index, letter) in tab1.enumerated() {
            //3
            if letter != " " {
                let tile = TileView(letter: letter, sideLength: tileSide)
                tile.randomize()
                tile.dragDelegate = self
                tile.center = CGPoint(x: xOffset + CGFloat(index)*(tileSide + 120), y: ScreenHeight/4*1.7)
                
                //4
                tiles.append(tile)
                gameView.addSubview(tile)
               
            }
        }
        
        
    }
    
    
    func checkIfSuccess() {
        
        for targetView in targets {
            
            if !targetView.isMatched {
                return
            }
        }
        print("game over")
        amountLevel += 1
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addlevel"), object: nil)
        
    }
    
    func clearBoard() {
        tiles.removeAll(keepingCapacity: false)
        targets.removeAll(keepingCapacity: false)
        
        for view in gameView.subviews  {
            view.removeFromSuperview()
        }
      
    }
    
    func successTile(tileView: TileView, targetView: TargetView) {
        
        // okreslamy, ze ten tile oraz target zostal juz uzyte, targetView bedzie nam pozniej potrzebny przy sprawdzaniu czy wszystkie targetView zostaly wypelnione
        targetView.isMatched = true
        tileView.isMatched = true
        
        // nie uzywamy juz touches na tile
        tileView.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.35, delay: 0.00, options: .curveEaseOut, animations: {
            // centrujemy nasz tileView wzgledem targetView i wylaczamy wszelkie rotacje na tile
            tileView.center = targetView.center
            tileView.transform = CGAffineTransform.identity
            
        }, completion: { _ in
            targetView.isHidden = true
        })
    }
    
    func failureTile(tileView: TileView) {
        
        tileView.randomize()
        
        UIView.animate(withDuration: 0.35, delay: 0.00, options: .curveEaseOut, animations: {
            
            tileView.center = CGPoint(x: tileView.center.x + CGFloat(randomNumber(minX:0, maxX:40)-20), y:  tileView.center.y + CGFloat(randomNumber(minX:20, maxX:30)))
            
        }, completion: nil)
    }
    
    
    
}



extension GameController: TileDragDelegateProtocol {
    
    func tileView(tileView: TileView, didDragToPoint point: CGPoint) {
        // sprawdzamy tutaj czy punkt polozenia obrazka znajduje sie w ktoryms z targetView
        
        var targetView: TargetView?
        for tv in targets {
            if tv.frame.contains(point) && !tv.isMatched {
                targetView = tv
                break
            }
        }
        
        if let targetView = targetView {
            
            if targetView.letter == tileView.letter {
               
                
                successTile(tileView: tileView, targetView: targetView)
                data.points += level.pointsPerTitle
                hud.gamePoints.value = data.points
                
            } else {
               
                failureTile(tileView: tileView)
                data.points -= level.pointsPerTitle/2
                hud.gamePoints.value = data.points
            }
            
            self.checkIfSuccess()
        }
    }
    
}
