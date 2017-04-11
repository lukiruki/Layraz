


import UIKit

class HUDView: UIView {
    
    var stopwatch: StopwatchView
    var gamePoints: CounterLabelView
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(frame:")
    }
    
    override init(frame:CGRect) {
        self.stopwatch = StopwatchView(frame:CGRect(x: ScreenWidth/2-150,y: 0,width: 300, height: 100))
        self.stopwatch.setSeconds(seconds: 0)
        
        self.gamePoints = CounterLabelView(frame: CGRect(x: ScreenWidth-200, y: 30, width: 200, height: 70))
        gamePoints.textColor = UIColor(red: 0.38, green: 0.098, blue: 0.035, alpha: 1)
        gamePoints.value = 0
        
        super.init(frame:frame)
        self.addSubview(self.stopwatch)
        self.addSubview(gamePoints)
        
        var pointsLabel = UILabel(frame: CGRect(x: ScreenWidth-340, y: 30, width: 140, height: 70))
        pointsLabel.backgroundColor = UIColor.clear
        //pointsLabel.font = FontHUD
        pointsLabel.text = " Points:"
        self.addSubview(pointsLabel)
        
        // dzieki temu zabiegowi bedziemy mogli uzyc touches w tileView poniewaz hud znajduje sie na samej gorze i przesłania inne widoki wiec musimy mu wylaczyc touches, zeby widok pod nim mogl go uzywac
        self.isUserInteractionEnabled = false
    }
}
