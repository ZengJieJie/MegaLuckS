//
//  GameScene.swift
//  Mega Luck Slot Bliss
//
//  Created by SSS NiB on 03/09/24.
//

import UIKit
import SceneKit

enum CollisionCategory: Int {
    case none = 0
    case bullet = 1
    case enemy = 2
    case tank = 3
}

class GameScene: SCNScene, SCNPhysicsContactDelegate {
    
    var tankNode: SCNNode!
    var enemies: [SCNNode] = []
    let cameraNode = SCNNode()
    let ambientLightNode = SCNNode()
    let lightNode = SCNNode()
    let floor = SCNFloor()
    var floorNode = SCNNode()
    
    weak var delegate: GameSceneDelegate?
    
    override init() {
        super.init()
        
        setupScene()
        setupTank()
        startEnemySpawnTimer()
        physicsWorld.contactDelegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupScene() {
        
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 7, z: 10)
        cameraNode.look(at: SCNVector3Zero)
        cameraNode.name = "cameraNode"
        rootNode.addChildNode(cameraNode)
        
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        rootNode.addChildNode(lightNode)
        
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        rootNode.addChildNode(ambientLightNode)
        
        
        floorNode = SCNNode(geometry: floor)
        let floorMaterial = SCNMaterial()
        floorMaterial.diffuse.contents = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        floorMaterial.roughness.contents = 0.5
        floor.materials = [floorMaterial]
        rootNode.addChildNode(floorNode)
        
        physicsWorld.gravity = SCNVector3.init(x: 0, y: 0, z: 0)
    }
    
    func setupTank() {
        
        guard let tankScene = SCNScene(named: "tank.obj") else {
            print("Failed to load tank model from 'tank.obj'")
            return
        }
        
        tankNode = tankScene.rootNode
        
        let texture = UIImage(named: "tank")
        
        applyTextureToNode(tankNode, texture: texture)
        
        tankNode.position = SCNVector3(x: 0, y: 0.28, z: 0)
        tankNode.scale = SCNVector3(1,1,1)
        
        tankNode.physicsBody = SCNPhysicsBody(
            type: .kinematic,
            shape: SCNPhysicsShape(
                node: tankNode,
                options: [
                    SCNPhysicsShape.Option.keepAsCompound: true
                ]
            )
        )
        tankNode.physicsBody?.categoryBitMask = CollisionCategory.tank.rawValue
        tankNode.physicsBody?.contactTestBitMask = CollisionCategory.enemy.rawValue
        tankNode.physicsBody?.collisionBitMask = CollisionCategory.none.rawValue
        
        rootNode.addChildNode(tankNode)
    }
    
    private func applyTextureToNode(_ node: SCNNode, texture: UIImage?) {
        
        let material = SCNMaterial()
        material.diffuse.contents = texture
        material.isDoubleSided = true
        node.geometry?.materials = [material]
        
        for childNode in node.childNodes {
            applyTextureToNode(childNode, texture: texture)
        }
    }
    
    func startEnemySpawnTimer() {
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(spawnEnemy), userInfo: nil, repeats: true)
    }
    
    @objc func spawnEnemy() {
        let enemyNode = createEnemy()
        enemies.append(enemyNode)
        rootNode.addChildNode(enemyNode)
        
        // Start enemy movement
        moveEnemy(enemyNode)
    }
    
    func createBullet() -> SCNNode {
        let bulletGeometry = SCNSphere(radius: 0.1)
        bulletGeometry.firstMaterial?.diffuse.contents = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let bulletNode = SCNNode(geometry: bulletGeometry)
        //        bulletNode.position = tankNode.position
        bulletNode.position = SCNVector3(x: tankNode.position.x, y: tankNode.position.y + 0.68, z: tankNode.position.z)
        bulletNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        bulletNode.physicsBody?.categoryBitMask = CollisionCategory.bullet.rawValue
        bulletNode.physicsBody?.contactTestBitMask = CollisionCategory.enemy.rawValue
        bulletNode.physicsBody?.collisionBitMask = CollisionCategory.none.rawValue
        
        return bulletNode
    }
    
    func createEnemy() -> SCNNode {
        
        let enemyNode = createDiamondGeometry()
        
        // Generate random X and Z positions within the specified ranges
        let randomXPosition = randomPosition(in: -100...(-30), or: 30...100)
        let randomZPosition = randomPosition(in: -100...(-30), or: 30...100)

        // Set the enemy's position
        enemyNode.position = SCNVector3(randomXPosition, 0.5, randomZPosition)

        // Set up the enemy physics body
        enemyNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        enemyNode.physicsBody?.categoryBitMask = CollisionCategory.enemy.rawValue
        enemyNode.physicsBody?.contactTestBitMask = CollisionCategory.bullet.rawValue
        enemyNode.physicsBody?.collisionBitMask = CollisionCategory.none.rawValue
        enemyNode.physicsBody?.isAffectedByGravity = false
        
        return enemyNode
    }

    // Helper function to generate random positions in negative or positive ranges
    func randomPosition(in range1: ClosedRange<Float>, or range2: ClosedRange<Float>) -> Float {
        return Bool.random() ? Float.random(in: range1) : Float.random(in: range2)
    }

    
    func createDiamondGeometry() -> SCNNode {
        
        let box = SCNBox(width: 1, height: 2, length: 1, chamferRadius: 0.0)
        
        let materials = [
            createMaterial(named: "zombie1.png"), // Front face
            createMaterial(named: "zombie2.png"), // Right face
            createMaterial(named: "zombie3.png"), // Back face
            createMaterial(named: "zombie4.png"), // Left face
            createMaterial(named: "zombie5.png"), // Top face
            createMaterial(named: "zombie6.png")  // Bottom face
        ]
        
        // Assign the materials to the box
        box.materials = materials
        
        // Create the node with the box geometry
        let zombieNode = SCNNode(geometry: box)
        zombieNode.position = SCNVector3(Float.random(in: -10...10), 0.5, Float.random(in: -10...10))
        
        // Set up physics for the zombie box
        zombieNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: box, options: nil))
        zombieNode.physicsBody?.categoryBitMask = CollisionCategory.enemy.rawValue
        zombieNode.physicsBody?.contactTestBitMask = CollisionCategory.bullet.rawValue
        zombieNode.physicsBody?.collisionBitMask = CollisionCategory.none.rawValue
        zombieNode.physicsBody?.isAffectedByGravity = false
        
        return zombieNode
        
    }
    
    func createMaterial(named imageName: String) -> SCNMaterial {
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: imageName)
        material.isDoubleSided = true // Render both sides if necessary
        return material
    }
    
    func moveEnemy(_ enemyNode: SCNNode) {
        guard let tankNode = tankNode else { return }
        
        let direction = SCNVector3(
            tankNode.position.x - enemyNode.position.x,
            tankNode.position.y - enemyNode.position.y,
            tankNode.position.z - enemyNode.position.z
        )
        
        let length = sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z)
        let normalizedDirection = SCNVector3(
            direction.x / length,
            direction.y / length,
            direction.z / length
        )
        
        let moveAction = SCNAction.move(by: normalizedDirection * 0.1, duration: 0.1)
        let repeatAction = SCNAction.repeatForever(moveAction)
        
        enemyNode.runAction(repeatAction)
    }
    
    func fireBullet() {
        
        let bulletNode = createBullet()
        rootNode.addChildNode(bulletNode)
        
        let currentFront = tankNode.presentation.worldFront
        let rotatedBulletDirection = SCNVector3(currentFront.z, currentFront.y, -currentFront.x) * 50
        let moveBulletAction = SCNAction.move(by: rotatedBulletDirection, duration: 3.0)
        
        bulletNode.runAction(moveBulletAction) {
            
            bulletNode.removeFromParentNode()
        }
        
    }
    
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
        let (nodeA, nodeB) = (contact.nodeA, contact.nodeB)
        
        if (nodeA.physicsBody?.categoryBitMask == CollisionCategory.tank.rawValue &&
            nodeB.physicsBody?.categoryBitMask == CollisionCategory.enemy.rawValue){
            
            nodeB.removeFromParentNode()
            
            delegate?.healthSet(-1)
            
        }else if (nodeA.physicsBody?.categoryBitMask == CollisionCategory.enemy.rawValue &&
                  nodeB.physicsBody?.categoryBitMask == CollisionCategory.tank.rawValue){
            
            nodeA.removeFromParentNode()
            
            delegate?.healthSet(-1)
            
        }
        
        if (nodeA.physicsBody?.categoryBitMask == CollisionCategory.bullet.rawValue &&
            nodeB.physicsBody?.categoryBitMask == CollisionCategory.enemy.rawValue) ||
            (nodeB.physicsBody?.categoryBitMask == CollisionCategory.bullet.rawValue &&
             nodeA.physicsBody?.categoryBitMask == CollisionCategory.enemy.rawValue) {
            
            nodeA.removeFromParentNode()
            nodeB.removeFromParentNode()
            
            delegate?.didAddScore()
            
        }
    }
    
    func rotateTank(left: Bool) {
        let rotationValue = CGFloat(left ? -0.1 : 0.1)
        tankNode.runAction(SCNAction.rotateBy(x: 0, y: rotationValue, z: 0, duration: 0.1))
        updateCameraPosition()
    }
    
    func updateCameraPosition() {
        guard let cameraNode = rootNode.childNode(withName: "cameraNode", recursively: true) else { return }

        // Get the tank's position and its forward direction (worldFront)
        let tankPosition = tankNode.presentation.position
        let tankFront = tankNode.presentation.worldFront

        // Set the desired distance and height for the camera relative to the tank
        let cameraDistance: Float = 4.0  // Distance behind the tank
        let cameraHeight: Float = 2.0     // Height above the tank
        
        let cameraPosition = SCNVector3(
            tankPosition.x - (tankFront.z * cameraDistance),  // X-axis: Use tank's Z-axis for positioning behind
            tankPosition.y + cameraHeight,                    // Y-axis: Add height to place camera above tank
            tankPosition.z + (tankFront.x * cameraDistance)   // Z-axis: Use tank's X-axis for positioning behind
        )

        // Set the camera position behind the tank at an angle
        cameraNode.position = cameraPosition

        cameraNode.eulerAngles = SCNVector3(-Float.pi / 20, 0, 0)
        
        // Make the camera look at the tank
        cameraNode.look(at: tankPosition)
    }

}

extension SCNVector3 {
    static func * (vector: SCNVector3, scalar: Float) -> SCNVector3 {
        return SCNVector3(vector.x * scalar, vector.y * scalar, vector.z * scalar)
    }
}

