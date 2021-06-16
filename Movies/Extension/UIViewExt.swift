//
//  UIViewExt.swift
//  Movies
//
//  Created by Adis Mulabdic on 13.06.2021..
//

import UIKit

extension UIView {
    @IBInspectable
        var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                layer.cornerRadius = newValue
            }
        }

        @IBInspectable
        var borderWidth: CGFloat {
            get {
                return layer.borderWidth
            }
            set {
                layer.borderWidth = newValue
            }
        }
        
        @IBInspectable
        var borderColor: UIColor? {
            get {
                if let color = layer.borderColor {
                    return UIColor(cgColor: color)
                }
                return nil
            }
            set {
                if let color = newValue {
                    layer.borderColor = color.cgColor
                } else {
                    layer.borderColor = nil
                }
            }
        }
        
        @IBInspectable
        var shadowRadius: CGFloat {
            get {
                return layer.shadowRadius
            }
            set {
                layer.shadowRadius = newValue
            }
        }
        
        @IBInspectable
        var shadowOpacity: Float {
            get {
                return layer.shadowOpacity
            }
            set {
                layer.shadowOpacity = newValue
            }
        }
        
        @IBInspectable
        var shadowOffset: CGSize {
            get {
                return layer.shadowOffset
            }
            set {
                layer.shadowOffset = newValue
            }
        }
        
        @IBInspectable
        var shadowColor: UIColor? {
            get {
                if let color = layer.shadowColor {
                    return UIColor(cgColor: color)
                }
                return nil
            }
            set {
                if let color = newValue {
                    layer.shadowColor = color.cgColor
                } else {
                    layer.shadowColor = nil
                }
            }
        }
    
    private static var _isCircle: Bool = false
    
    @IBInspectable var setCircle:Bool {
        get {
            return UIView._isCircle
        }
        set(newValue) {
            if(newValue == true){
                layer.cornerRadius = self.frame.size.width / 2
                self.clipsToBounds = true
            }
        }
    }
    func hideViewWithSubviews() {
        self.subviews.forEach { $0.isHidden = true }
        self.isHidden = true
    }
    
    func showViewWithSubviews() {
        self.subviews.forEach { $0.isHidden = false }
        self.isHidden = false
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func animateViewWith(alpha value: CGFloat) {
        UIView.animate(withDuration: 0.6) {
            self.alpha = value
        }
    }
}
