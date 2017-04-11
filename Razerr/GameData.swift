//
//  GameData.swift
//  Razerr
//
//  Created by Aplikacje on 21/03/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import Foundation
import UIKit

class GameData {
    
    var points: Int = 0 {
        didSet {
            // obserwujemy didset czy gracz ma mniej niz 0 pkt. Jezeli tak to przypisanie mu wartosc 0, a jezeli ma wiecej niz 0 to ilosc pkt jaką zdobył
            points = max(points,0)
        }
    }
    
}
