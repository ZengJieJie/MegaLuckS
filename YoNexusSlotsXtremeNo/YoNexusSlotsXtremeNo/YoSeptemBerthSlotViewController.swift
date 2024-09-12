//
//  SlotViewController.swift
//  Nexus Slots Xtreme Pro
//
//  Created by Softs Solution M on 06/09/24.
//

import UIKit
import AVFoundation

class YoSeptemBerthSlotViewController: UIViewController {

    @IBOutlet weak var turnlbl: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
//    @IBOutlet weak var progressView: UIProgressView!
  
    
    var images: [String] = ["1", "2", "3","4", "5", "6"]
    var selectedImages: [String] = ["", "", ""]
    var turnCount: Int = 0
    var matchCount: Int = 0
    var name: String?
    var audioPlayer: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        updateTurnLabel()
//        nameLbl.text = name
    }
    
    @IBAction func spinBtn(_ sender: UIButton) {
        if let soundURL = Bundle.main.url(forResource: "YoSeptem", withExtension: "mp3") {
                   do {
                       audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                       audioPlayer?.play()
                   } catch {
                       print("Error playing sound: \(error)")
                   }
               } else {
                   print("Sound file not found")
               }
        
        if turnCount < 100 {
            turnCount += 1
            updateTurnLabel()
            
            for component in 0..<pickerView.numberOfComponents {
                let randomRow = Int.random(in: 0..<images.count)
                pickerView.selectRow(randomRow, inComponent: component, animated: true)
                
                let selectedCard = images[randomRow]
                selectedImages[component] = selectedCard
            }
            
            // Check if all selected card types are the same
            if selectedImages[0] == selectedImages[1] && selectedImages[1] == selectedImages[2] {
                let Alert = UIAlertController(title: "Matched!", message: "Slots are matched", preferredStyle: UIAlertController.Style.alert)
                present(Alert, animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.dismiss(animated: true)
                }
                matchCount += 1
            } else {
                print("Try again")
//                scorelbl.text = "Try again!"
            }
            
            // Update progress view
//            let progress = Float(turnCount) / 50.0
//            progressView.setProgress(progress, animated: true)
//
            // Check if the game is over
            if turnCount == 100 {
                showGameOverAlert()
            }
        } else {
            showGameOverAlert()
        }
        
        
    }
    
    func updateTurnLabel() {
        turnlbl.text = "Turn: \(turnCount)/100"
    }
    
    func showGameOverAlert() {
        let gameOverAlert = UIAlertController(title: "Game Over", message: "You have reached turns.\nTotal matches: \(matchCount)", preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart", style: .default) { (_) in
            self.restartGame()
        }
        gameOverAlert.addAction(restartAction)
        present(gameOverAlert, animated: true, completion: nil)
    }
    
    func restartGame() {
        turnCount = 0
        matchCount = 0
        updateTurnLabel()
//        scorelbl.text = ""
//        progressView.setProgress(0.0, animated: false)
//        pickerView.reloadAllComponents()
    }
}

extension YoSeptemBerthSlotViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count * 10 // Adjust as needed
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let index = row % images.count
        let imgType = images[index]
        
        let imageView = UIImageView(image: UIImage(named: imgType))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
}
