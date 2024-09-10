//
//  MegaLuckDifficultyViewController.swift
//  MegaLuckSlotBliss
//
//  Created by adin on 2024/9/10.
//

import UIKit

class MegaLuckDifficultyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backclick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func Easyclick(_ sender: Any) {
     
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                if let secondVC = storyboard.instantiateViewController(withIdentifier: "MegaLuckCollectScoreVC") as? MegaLuckCollectScoreVC {
                    secondVC.timevctime=5.0
                  
                    self.show(secondVC, sender: self)
                }
    }
    
    @IBAction func Normalclick(_ sender: Any) {
      
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                if let secondVC = storyboard.instantiateViewController(withIdentifier: "MegaLuckCollectScoreVC") as? MegaLuckCollectScoreVC {
                    secondVC.timevctime=2.5
                  
                    self.show(secondVC, sender: self)
                }
    }
    
    
    @IBAction func Hardclick(_ sender: Any) {
      
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                if let secondVC = storyboard.instantiateViewController(withIdentifier: "MegaLuckCollectScoreVC") as? MegaLuckCollectScoreVC {
                    secondVC.timevctime=1.0
                  
                    self.show(secondVC, sender: self)
                }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
