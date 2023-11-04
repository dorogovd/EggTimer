//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 5*60, "Medium": 7*60, "Hard": 12*60]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    var player: AVAudioPlayer!
    
    @IBOutlet weak var progress: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()

        var hardness = sender.currentTitle!
       
        totalTime = eggTimes[hardness]!
        
        progress.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    @objc func countdown() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progress.setProgress(Float(secondsPassed) / Float(totalTime), animated: true)
            print(progress.progress)
        } else {
            timer.invalidate()
            titleLabel.text = "Done"
            playSound(soundName: "alarm_sound")
        }
    }
    
    func playSound(soundName: String?) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
}
