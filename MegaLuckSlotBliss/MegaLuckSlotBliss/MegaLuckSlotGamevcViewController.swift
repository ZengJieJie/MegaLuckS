//
//  MegaLuckSlotGamevcViewController.swift
//  MegaLuckSlotBliss
//
//  Created by adin on 2024/9/6.
//

import UIKit

class MegaLuckSlotGamevcViewController: UIViewController {

    // Outlets for UI elements
    @IBOutlet weak var slot1Label: UILabel!
    @IBOutlet weak var slot2Label: UILabel!
    @IBOutlet weak var slot3Label: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var imgGif: UIImageView!
    
    var score: Int = 0
    var lives: Int = 20 // Starting with 20 lives
    let maxLives: Int = 20 // Set max lives to 20
    let slotSymbols = ["🍒", "🍋", "🍉", "🍇", "7"]
    let userDefaultsKey = "SlotGameData"
    
    var isSpinning: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgGif.image = UIImage.getGIFThumbnail(gifName: "attack")
        
        loadGameData()
        
        updateScore()
        updateLives()
    }
    
    @IBAction func spinAction(_ sender: UIButton) {
        
        imgGif.image = UIImage.gifImageWithName("attack")
        
        if isSpinning { return }
        
        if lives <= 0 {
            showGameOverAlert()
            return
        }
        
        isSpinning = true
        
        DispatchQueue.main.asyncAfter(deadline: .now()+4.25){
            
            self.imgGif.image = UIImage.getGIFThumbnail(gifName: "attack")
            
            UIView.animate(withDuration: 0.5, animations: {
                self.slot1Label.alpha = 0.0
                self.slot2Label.alpha = 0.0
                self.slot3Label.alpha = 0.0
            }) { _ in
                self.spinSlots()
                UIView.animate(withDuration: 0.5) {
                    self.slot1Label.alpha = 1.0
                    self.slot2Label.alpha = 1.0
                    self.slot3Label.alpha = 1.0
                } completion: { _ in
                    self.checkMatch()
                    self.isSpinning = false
                }
            }
            
            self.lives -= 1
            self.updateLives()
            
        }
        
    }
    
    func spinSlots() {
        let randomSymbol1 = slotSymbols.randomElement()!
        let randomSymbol2 = slotSymbols.randomElement()!
        let randomSymbol3 = slotSymbols.randomElement()!
        
        // Set random symbols for each slot label
        slot1Label.text = randomSymbol1
        slot2Label.text = randomSymbol2
        slot3Label.text = randomSymbol3
    }
    
    func checkMatch() {
        let firstSymbol = slot1Label.text
        let secondSymbol = slot2Label.text
        let thirdSymbol = slot3Label.text
        
        var points = 0
        
        // Check if two or three symbols match
        if firstSymbol == secondSymbol && secondSymbol == thirdSymbol {
            points = 20 // All three match
        } else if firstSymbol == secondSymbol || secondSymbol == thirdSymbol || firstSymbol == thirdSymbol {
            points = 10 // Two symbols match
        } else {
            points = -5 // No match
        }
        
        score += points
        updateScore()
        
        // Save game data
        saveGameData()
    }
    
    func updateScore() {
        scoreLabel.text = "🌶️: \(score)"
    }
    
    func updateLives() {
        livesLabel.text = "♥︎: \(lives)"
    }
    
    func showGameOverAlert() {
        let alert = UIAlertController(title: "Game Over", message: "You've run out of lives!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.restartGame()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func restartGame() {
        lives = maxLives
        score = 0
        updateLives()
        updateScore()
        saveGameData()
    }
    
    // Save game data to UserDefaults
    func saveGameData() {
        let gameData = ["score": score, "lives": lives] as [String : Any]
        UserDefaults.standard.set(gameData, forKey: userDefaultsKey)
    }
    
    // Load game data from UserDefaults
    func loadGameData() {
        if let savedData = UserDefaults.standard.dictionary(forKey: userDefaultsKey) as? [String: Int] {
            score = savedData["score"] ?? 0
            lives = savedData["lives"] ?? maxLives
        }
    }
    
    
}
