////
////  Radius.swift
////  Epic Slots Quest Pro
////
////  Created by Softs Solution on 27/07/24.
////
//
//import Foundation
import UIKit
//
func showAlert(ttl: String, msg: String, Button: String, VC: UIViewController) {
    
    let Alert = UIAlertController(title: ttl, message: msg, preferredStyle: .alert)
    let Action = UIAlertAction(title: Button, style: .default)
    Alert.addAction(Action)
    VC.present(Alert, animated: true)
    
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = (newValue > 0)
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
}

extension UIStackView{
    
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
}

@IBDesignable
class CustomCornerView: UIView {
    
    @IBInspectable var topLeftCornerRadius: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var topRightCornerRadius: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var bottomLeftCornerRadius: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var bottomRightCornerRadius: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    private func updateCornerRadius() {
        var corners: CACornerMask = []
        
        if topLeftCornerRadius {
            corners.insert(.layerMinXMinYCorner)
        }
        if topRightCornerRadius {
            corners.insert(.layerMaxXMinYCorner)
        }
        if bottomLeftCornerRadius {
            corners.insert(.layerMinXMaxYCorner)
        }
        if bottomRightCornerRadius {
            corners.insert(.layerMaxXMaxYCorner)
        }
        
        layer.maskedCorners = corners
    }
}
