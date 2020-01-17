//
//  ReminderPlayer.swift
//  heshuibao
//
//  Created by 舒蕾 on 2020/1/13.
//  Copyright © 2020 erlingerling. All rights reserved.
//

import UIKit
import AVFoundation

class ReminderPlayer: NSObject {

    var player: AVAudioPlayer?
    
    func startPlayWithName(name: String) {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        } catch {
        }
        
        // 初始化播放器
        let filePath = Bundle.main.path(forResource: name, ofType: nil)
        let url = URL.init(fileURLWithPath: filePath ?? "")
        do {
            player = try AVAudioPlayer.init(contentsOf: url)
        } catch {
        }
        
        // 设置代理
        player?.delegate = self as? AVAudioPlayerDelegate
        
        // 播放
        player?.prepareToPlay()
        player?.play()
        
    }
    
    func stopPlay() {
        player?.stop()
    }
}
