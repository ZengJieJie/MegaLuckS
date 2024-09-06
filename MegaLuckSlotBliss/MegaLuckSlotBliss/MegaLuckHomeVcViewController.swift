//
//  MegaLuckHomeVcViewController.swift
//  MegaLuckSlotBliss
//
//  Created by adin on 2024/9/6.
//

import UIKit
import StoreKit
class MegaLuckHomeVcViewController: UIViewController {

    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var scrl: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var transform = CATransform3DIdentity
        
        transform.m34 = -1.0 / 200.0
        
        for (i,v) in stack.subviews.enumerated(){
            
            UIView.animate(withDuration: 0.5) {
                
                v.layer.transform = CATransform3DRotate(transform, (i%2 == 0 ? -1 : 1) * .pi/10.0, 0, 1, 0)
                
                
            }
            
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
            
            self.scrl.setContentOffset(CGPoint(x: self.stack.bounds.width/2 - self.scrl.bounds.width/2, y: 0), animated: true)
            
        }
        
    }
    
    
    @IBAction func btnRate(_ sender: Any) {
        
        SKStoreReviewController.requestReview()
        
    }
    
}
