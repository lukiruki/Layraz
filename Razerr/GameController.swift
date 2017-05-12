

import Foundation
import UIKit


class GameController {
    
    var gameView: UIView!
    var hud: HUDView!
    var sentence: Sentences!
    var amountLevel: Int = 0
    
    private var secondsLeft: Int = 0
    private var timer: Timer?
    private var tiles = [TileView]()
    
    fileprivate var data = GameData()
    fileprivate var targets = [TargetView]()
  
    init() {
        
    }
    
    func dealRandomAnagram () {
        
        assert(sentence != nil, "no sentence loaded")
        
    
        
        // calculate size of title
        let tileSide = ceil(ScreenWidth * 0.9 / CGFloat(max(sentence.rightSentences.characters.count, sentence.falseSentences.characters.count))) - TileMargin
        
        // searching position first title
        var xOffset = (ScreenWidth - CGFloat(12.0) * (tileSide + TileMargin)) / 2.0
        
        // centrujemy nasza pozycje dla tile, ktora ma wartosc od lewego x wiec trzeba to wycentrowac
        xOffset += tileSide / 2.0
        
        //initialize target list
        targets = []
        
        let tab2 = sentence.rightSentences.components(separatedBy: " ")
        
        for (index, letter) in tab2.enumerated() {
            if letter != " " {
                let target = TargetView(letter: letter, sideLength: tileSide)
                target.center = CGPoint(x: xOffset + CGFloat(index)*(tileSide + 120), y: ScreenHeight/5)
                
                targets.append(target)
                gameView.addSubview(target)
                
            }
        }
        
        tiles = []
        
        let tab1 = sentence.falseSentences.components(separatedBy: " ")
        
        for (index, letter) in tab1.enumerated() {
            
            if letter != " " {
                let tile = TileView(letter: letter, sideLength: tileSide)
                tile.randomize()
                tile.dragDelegate = self
                tile.center = CGPoint(x: xOffset + CGFloat(index)*(tileSide + 120), y: ScreenHeight/4*1.7)
                
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
        
        // when we matches target and tile we set target and tile on true because we do not want use this object
        targetView.isMatched = true
        tileView.isMatched = true
        
        // we don't use touches on tile
        tileView.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.35, delay: 0.00, options: .curveEaseOut, animations: {
            // center ours tileView relative targetView and we turn off all rotation on title
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
                data.points += 10
                hud.gamePoints.value = data.points
                
            } else {
               
                failureTile(tileView: tileView)
                data.points -= 10/2
                hud.gamePoints.value = data.points
            }
            
            self.checkIfSuccess()
        }
    }
    
}
