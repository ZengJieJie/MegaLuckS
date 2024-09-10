//
//  GameScene1.swift
//  MegaLuckSlotBliss
//
//  Created by Hitesh's Mac on 09/09/24.
//

import SpriteKit

// Define the delegate protocol for score updates
protocol GameSceneDelegate1: AnyObject {
    func didUpdateScore(to newScore: Int)
    func gameOver()
}

class GameScene1: SKScene {
    var timenat=0.0;
    weak var scoreDelegate: GameSceneDelegate1?

    var score = 0 {
        didSet {
            scoreDelegate?.didUpdateScore(to: score)
        }
    }

    override func didMove(to view: SKView) {
        backgroundColor = UIColor.clear
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addFallingObject),
                SKAction.wait(forDuration: 0.5)
            ])
        ))
    }

    // Function to add either a random image (1-5) or a bomb
    func addFallingObject() {
        let objectType = Int.random(in: 0...4) // Random number between 0 and 4
        let object: SKSpriteNode

        if objectType == 0 {
            // Create bomb
            object = SKSpriteNode(imageNamed: "bomb")
            object.name = "bomb"
            
            // Set bomb size
            object.size = CGSize(width: 70, height: 70)
        } else {
            // Create a random image from 1 to 5
            let randomImageIndex = Int.random(in: 1...5) // Random number between 1 and 5
            object = SKSpriteNode(imageNamed: "\(randomImageIndex)")
            object.name = "coin" // Keep the name as "coin" for scoring purposes
            
            // Set coin size
            object.size = CGSize(width: 60, height: 60)
        }

        let randomX = CGFloat.random(in: 0..<size.width)
        object.position = CGPoint(x: randomX, y: size.height + object.size.height)

        addChild(object)

        // Make the object fall faster
        let moveAction = SKAction.move(to: CGPoint(x: randomX, y: -object.size.height), duration: timenat)
        let removeAction = SKAction.removeFromParent()
        object.run(SKAction.sequence([moveAction, removeAction]))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)

        // Check for collision with coins and bombs
        enumerateChildNodes(withName: "coin") { (node, _) in
            if node.contains(touchLocation) {
                node.removeFromParent()
                self.score += 1
            }
        }

        enumerateChildNodes(withName: "bomb") { (node, _) in
            if node.contains(touchLocation) {
                node.removeFromParent()
                self.endGame()
            }
        }
    }

    // Function to handle game over
    func endGame() {
        removeAllChildren()
        removeAllActions()
        
        // Optionally, pause the scene if needed
        isPaused = true
        
        // Notify the delegate that the game is over
        scoreDelegate?.gameOver()
    }
}
