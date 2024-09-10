//
//  MegaLuckFebdViewController.swift
//  MegaLuckSlotBliss
//
//  Created by adin on 2024/9/10.
//

import UIKit

class MegaLuckFebdViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var backview: UIView!
    
    @IBOutlet weak var fedbview: UITextView!
    
    var TipsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        fedbview.isEditable = true
        fedbview.delegate = self
        fedbview.tintColor = UIColor.white
                
        TipsLabel = UILabel(frame: CGRect(x: 5, y: 8, width: fedbview.frame.size.width - 10, height: 20))
        TipsLabel.text = "Enter your comments here"
        TipsLabel.textColor = UIColor.black
        TipsLabel.font = UIFont.boldSystemFont(ofSize: 21)
                
        fedbview.addSubview(TipsLabel)
        TipsLabel.isHidden = fedbview.text.count > 0
        
        // Do any additional setup after loading the view.
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        TipsLabel.isHidden = true
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            TipsLabel.isHidden = textView.text.count > 0
        }

        func textViewDidChange(_ textView: UITextView) {
            TipsLabel.isHidden = textView.text.count > 0
        }
    
    
    @IBAction func fedbback(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func submitclick(_ sender: UIButton) {
        if fedbview.text.count > 0 {
            
                   let delayTime = DispatchTime.now() + 0.8
                   DispatchQueue.main.asyncAfter(deadline: delayTime) {
                       
                       let alertController = UIAlertController(title: "Tips", message: "We have received your comments", preferredStyle: .alert)
                       
                       let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                           self.fedbview.text = ""
                       }
                       
                       alertController.addAction(okAction)
                       self.present(alertController, animated: true, completion: nil)
                   }
               } else {
                   let alertController = UIAlertController(title: "Tips", message: "Please enter your comments", preferredStyle: .alert)
                   
                   let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                   
                   alertController.addAction(okAction)
                   self.present(alertController, animated: true, completion: nil)
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
