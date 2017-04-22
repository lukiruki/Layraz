//
//  Config.swift
//  Razerr
//
//  Created by Aplikacje on 22/04/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//


import Foundation
import UIKit

//UI Constants
let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

let TileMargin: CGFloat = 20.0

//Random number generator
func randomNumber(minX: UInt32, maxX: UInt32) -> Int {
    let result = (arc4random() % (maxX - minX + 1)) + minX
    return Int(result)
}


let FontHUD = UIFont(name:"comic andy", size: 62.0)
let FontHUDBig = UIFont(name:"comic andy", size:120.0)


let SoundDing = "ding.mp3"
let SoundWrong = "wrong.m4a"
let SoundWin = "win.mp3"
let AudioEffectFiles = [SoundDing, SoundWrong, SoundWin]

