//
//  YoSeptemBerthBaseController.swift
//  YoNexusSlotsXtremeNo
//
//  Created by jin fu on 2024/9/12.
//

import UIKit

class YoSeptemBerthBaseController: UIViewController {

    let bg: UIImageView = UIImageView(image: UIImage(named: "YoBgImg"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        bg.frame = UIScreen.main.bounds
        view.addSubview(bg)
        view.sendSubviewToBack(bg)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.sendSubviewToBack(bg)
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
