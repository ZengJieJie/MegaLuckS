//
//  CollectScoreVC.swift
//  MegaLuckSlotBliss
//
//  Created by Hitesh's Mac on 09/09/24.
//

import UIKit
import SpriteKit

class CollectScoreVC: UIViewController {

    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var Credit: UILabel!

    var score: Int = 0 {
        didSet {
            Credit.text = "Score: \(score)"
         }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameScene()
     }

    @IBAction func HistorySaved(_ sender: Any) {
        historySaved()
    }
    
    func historySaved() {
        
        let historyData: [String: Any] = ["right": score ]
        
        var historyArray = UserDefaults.standard.array(forKey: "history") as? [[String: Any]] ?? []
        historyArray.append(historyData)
        UserDefaults.standard.set(historyArray, forKey: "history")
        let alert = UIAlertController(title: "History", message: "Saved!!", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: true)
        }
    }
    private func setupGameScene() {
        
        // Create SKView with the same frame as View1
        let skView = SKView(frame: View1.bounds)
        skView.translatesAutoresizingMaskIntoConstraints = false
        View1.addSubview(skView)

        NSLayoutConstraint.activate([
            skView.topAnchor.constraint(equalTo: View1.topAnchor),
            skView.bottomAnchor.constraint(equalTo: View1.bottomAnchor),
            skView.leadingAnchor.constraint(equalTo: View1.leadingAnchor),
            skView.trailingAnchor.constraint(equalTo: View1.trailingAnchor)
        ])

        // Load the GameScene
        let scene = GameScene1(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .clear
        scene.scoreDelegate = self
        skView.backgroundColor = .clear
        // Present the scene
        skView.presentScene(scene)

        skView.ignoresSiblingOrder = true
       
    }

 

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - GameSceneDelegate
extension CollectScoreVC: GameSceneDelegate1 {
    func didUpdateScore(to newScore: Int) {
        self.score = newScore
    }

    func gameOver() {
        
        let alert = UIAlertController(title: "Game Over", message: "You hit a bomb!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.setupGameScene()
            self.score = 0
        }))
        present(alert, animated: true, completion: nil)
     }
}
