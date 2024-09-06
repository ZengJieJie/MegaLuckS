//
//  MegaLuckGetStartViewController.swift
//  MegaLuckSlotBliss
//
//  Created by adin on 2024/9/6.
//

import UIKit

class MegaLuckGetStartViewController: UIViewController {

    @IBOutlet weak var fieldName: UITextField!
    
    @IBOutlet weak var stack: UIStackView!
    
    @IBOutlet weak var bv1: UIVisualEffectView!
    @IBOutlet weak var bv2: UIVisualEffectView!
    
    let nameKey = "userName"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply 3D transform animations
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 500.0
        UIView.animate(withDuration: 0.5) {
            self.bv1.layer.transform = CATransform3DRotate(transform, .pi/20.0, 0, 1, 0)
            self.bv2.layer.transform = CATransform3DRotate(transform, -.pi/20.0, 0, 1, 0)
        }
        
        // Load saved name from UserDefaults and display in the text field
        loadUserName()
    }
    
    @IBAction func btnStart(_ sender: Any) {
        // Save the name to UserDefaults
        saveUserName()
        
        // Navigate to HomeVC
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! MegaLuckHomeVcViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Save the user's name to UserDefaults
    func saveUserName() {
        let userName = fieldName.text ?? ""
        UserDefaults.standard.set(userName, forKey: nameKey)
    }
    
    // Load the saved name from UserDefaults
    func loadUserName() {
        if let savedName = UserDefaults.standard.string(forKey: nameKey) {
            fieldName.text = savedName
        }
    }
}
