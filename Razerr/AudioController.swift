//
//  AudioController.swift
//  Razerr
//
//  Created by Aplikacje on 21/03/17.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import AVFoundation

//class AudioController {
//    private var audio = [String:AVAudioPlayer]()
//    
////    func preloadAudioEffects(effectFileNames:[String]) {
////        for effect in AudioEffectFiles {
////            do {
////                // ladujemy soundUrl z filePath do url. ktorego uzyjemy w AVAudio
////                var soundURL = URL.init(fileURLWithPath: Bundle.main.resourcePath!)
////                try soundURL.appendPathComponent(effect)
////                
////                // ladujemy soundUrl do AvAudioPlayer
////                let player = try AVAudioPlayer(contentsOf: soundURL)
////                
////                
////                player.numberOfLoops = 0
////                player.prepareToPlay()
////                
////                // zapisujemy naszego playera (np win) w dictionary
////                audio[effect] = player
////            } catch {
////                assert(false, "Load sound failed")
////            }
////        }
//    }
//    
//    // sprawdzamy czy ten dzwiek juz jest otworzony, jezeli tak to wylaczamy , a inaczej uruchamiamy
//    
//    func playSound(name: String){
//        // pobieramy teraz AVAudio z dictionary no i gramy :)
//        if let player = audio[name] {
//            if player.isPlaying {
//                player.currentTime = 0
//            } else {
//                player.play()
//            }
//            
//        }
//    }
//}
