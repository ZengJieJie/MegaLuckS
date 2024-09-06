//
//  MegaLuckGamevcViewController.swift
//  MegaLuckSlotBliss
//
//  Created by adin on 2024/9/6.
//

import UIKit
import SceneKit
import QuartzCore
class MegaLuckGamevcViewController: UIViewController {
    
    @IBOutlet weak var fireButton: UIButton!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var progHealth: UIProgressView!
    @IBOutlet weak var lblHealth: UILabel!
    
    var scnView: SCNView!
    var gameScene: GameScene!
    
    var timr: Timer?
    
    var health = 100.0 {
        didSet {
            guard health > 1 else {
                return
            }
            DispatchQueue.main.async {
                self.progHealth.progress = Float(self.health / 100)
                self.lblHealth.text = "\(self.health)"
            }
        }
    }
    
    var score = 0 {
        didSet {
            DispatchQueue.main.async {
                self.lblScore.text = "KILL: 🧟‍♂️ \(self.score)"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        health = 100
        score = 0
        
        setupScene()
        setupControls()
    }
    
    func setupScene() {
        scnView = SCNView(frame: self.viewMain.bounds)
        scnView.backgroundColor = .clear
        scnView.allowsCameraControl = false
        scnView.autoenablesDefaultLighting = true
        viewMain.addSubview(scnView)
        
        gameScene = GameScene()
        gameScene.delegate = self
        scnView.scene = gameScene
        
        timr = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true, block: { _ in
            self.gameScene.fireBullet()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        timr?.invalidate()
    }
    
    func setupControls() {
        
        fireButton.addTarget(self, action: #selector(fireBullet), for: .touchUpInside)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPressGesture.minimumPressDuration = 0.1
        scnView.addGestureRecognizer(longPressGesture)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        scnView.addGestureRecognizer(panGesture)
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        
        let location = gesture.location(in: scnView)
        
        switch gesture.state {
            
        case .began, .changed:
            
            rotateTankBasedOnLocation(x: location.x)
        default:
            break
        }
    }

    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: scnView)
        gesture.setTranslation(CGPoint.zero, in: scnView)
        
        if translation.x != 0 {
            let rotationDirection = translation.x > 0 ? true : false
            gameScene.rotateTank(left: rotationDirection)
        }
    }

    func rotateTankBasedOnLocation(x: CGFloat) {
        if x < scnView.bounds.midX {
            gameScene.rotateTank(left: true)
        } else {
            gameScene.rotateTank(left: false)
        }
    }

    
    @objc func fireBullet() {
        gameScene.fireBullet()
    }
}

extension MegaLuckGamevcViewController: GameSceneDelegate {
    
    func healthSet(_ h: Int) {
        health += Double(h * 5)
    }
    
    func didAddScore() {
        score += 1
    }
}
