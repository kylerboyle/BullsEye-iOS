//
//  ViewController.swift
//  BullsEye2
//
//  Created by Kyler Boyle on 5/7/17.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    var currentVal = 50
    var targetVal = 0
    var score = 0
    var roundNum = 0
    

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewGame()
        updateLabels()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable =
                                trackLeftImage.resizableImage(withCapInsets: insets)
            slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
            slider.setMaximumTrackImage(trackRightResizable, for: .normal) }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        let difference = abs(targetVal - currentVal)
        var points = 10 - difference
        var message: String
        var title: String
        
        if(points > 0) {
            title = "Nice effort"
            // bonus points for +-1
            if(points == 10) {
                points += 50
                title = "Perfect!"
            } else if(points == 9){
                points += 25
                title = "Nearly had it!"
            }
            score += points
            message = "You scored \(points) points!"
        } else {
            title = "Not even close..."
            message = "No participation points!"
        }
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Sweet!", style: .default,
                                   handler: { action in
                                                self.startNewRound()
                                                self.updateLabels()
                                            })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentVal = lroundf(slider.value)
    }
    
    func startNewRound() {
        roundNum += 1
        targetVal = 1 + Int(arc4random_uniform(100))
        currentVal = 50
        slider.value = Float(currentVal)
        updateLabels()
    }
    
    func startNewGame() {
        score = 0
        roundNum = 0
        startNewRound()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetVal)
        scoreLabel.text = String(score)
        roundLabel.text = String(roundNum)
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        view.layer.add(transition, forKey: nil)
    }
}

