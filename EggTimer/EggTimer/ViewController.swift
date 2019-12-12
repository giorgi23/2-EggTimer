
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    let eggTime = ["Soft": 300, "Medium": 420, "Hard": 3,]
    var counter = 60
    var totalTime = 0
    var passedTime = 0
    var player: AVAudioPlayer?
        
    var timer = Timer ()

    @IBOutlet weak var displayTop: UILabel!
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    @IBOutlet weak var seconds: UILabel!
    
    
    @IBAction func timerPressed(_ sender: UIButton) {
        
        timer.invalidate()
        
        player?.stop()
        
        displayTop.text = "Boiling the egg"
        
        let buttonName = sender.currentTitle!
        
        counter = eggTime[buttonName]!
        
        totalTime = counter
        
        passedTime = 1
        
        seconds.text = String(counter)
        
        progressBar.progress = 0.0

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        }

    @objc func updateCounter() {
        //This generates a countdown
        if counter > 0 {
            counter -= 1
            seconds.text = String(counter)
            
        }
        
        print (passedTime)
        
        //This updates the bar according to how much time passed
        if passedTime < totalTime {
            
            let percentageProgress = Float(passedTime) / Float (totalTime)
            
            progressBar.progress = percentageProgress
            
            passedTime += 1
        }
        
        
        
        if counter == 0 {
            
            timer.invalidate()
            
            playSound()
            
            displayTop.text = "DONE!"
            
            progressBar.progress = 1.0
            
            seconds.text = "0"
        }
        
        
        
        
        
    }
    
    
    func playSound() {
        
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
}
    
