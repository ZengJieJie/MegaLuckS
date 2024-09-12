//
//  feedBackVC.swift
//  Tiger Tidbits
//
//  Created by M on 18/05/24.
//

import UIKit

class YoSeptemBerthFeedbackViewController: YoSeptemBerthBaseController {
    @IBOutlet weak var submitBtn: YoSeptemBerthButton!
    
    @IBOutlet weak var textFiled: YoSeptemBerthTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        //self.navigationItem.titleView?.isHidden = false
    }
    
    @IBAction func btn(_ sender: Any) {
        let alert:UIAlertController = UIAlertController(title: "Message", message: "successfully", preferredStyle: UIAlertController.Style.alert)
        
        let Ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(Ok)
        
       present(alert, animated: false)
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

}
