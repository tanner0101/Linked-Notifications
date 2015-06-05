//
//  LinkedNotificationView.swift
//  Decode
//
//  Created by Tanner Nelson on 4/3/15.
//

import UIKit

class LinkedNotificationView: NibView {
    
    // MARK: Class functions
    class func instantiate() -> LinkedNotificationView {
        var view = LinkedNotificationView()
        if let nibView = self.instantiate("LinkedNotificationView") as? LinkedNotificationView {
            view = nibView
        }
        return view;
    }
    
    //MARK: Initializations
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.iconImageView.layer.cornerRadius = 5
        self.iconImageView.clipsToBounds = true
        
        self.initializeBlur()
    }
    
    func initializeBlur() {
        self.backgroundColor = UIColor.clearColor()
        
        let blurEffect = UIBlurEffect(style: .Light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.bounds
        blurView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.insertSubview(blurView, atIndex: 0)
        
        var vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
        vibrancyView.frame = self.bounds
        vibrancyView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        blurView.contentView.addSubview(vibrancyView)
    }
    

    //MARK: Interface Elements
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK: Interface Actions
    @IBAction func mainButtonTouchDown(sender: UIButton) {
        self.depress()
    }
    
    @IBAction func mainButtonTouchUpInside(sender: UIButton) {
        if let onTap = self.onTap {
            onTap()
        }
        self.reset()
    }
    
    @IBAction func mainButtonTouchUpOutside(sender: UIButton) {
        self.reset()
    }
    
    @IBAction func mainButtonTouchCancel(sender: AnyObject) {
        self.reset()
    }
    
    //MARK: Constants
    let margin: CGFloat = 20
    let spacing: CGFloat = 8
    
    //MARK: Positioning
    var topConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    
    func addTo(superView: UIView, after lastView: UIView) {
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        superView.addSubview(self)
        
        superView.addConstraint( NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: superView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: self.margin))
        superView.addConstraint( NSLayoutConstraint(item: superView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: self.margin))
        
        self.moveUnderneath(view: lastView, shuffling: false)
    }
    
    func moveUnderneath(view lastView: UIView, shuffling: Bool) {
        
        if let constraint = self.topConstraint {
            self.superview?.removeConstraint(constraint)
            self.topConstraint = nil
        } else {
            self.alpha = 0
            self.transform = CGAffineTransformMakeTranslation(0, -100 )
        }
        
        if let superView = self.superview {
            self.topConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: lastView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: self.spacing)
            
            if let view = lastView as? LinkedNotificationView {
                view.bottomConstraint = self.topConstraint
            }
            
            if let constraint = self.topConstraint {
                superView.addConstraint( constraint )
            }
        }
        
        if !shuffling {
            self.layoutIfNeeded()
        }
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: nil, animations: {
            self.layoutIfNeeded()
            self.transform = CGAffineTransformMakeTranslation(0, 0)
            self.alpha = 1
        }, completion: nil)
    }
    
    func hide() {
        if let constraint = self.bottomConstraint {
            self.superview?.removeConstraint(constraint)
            self.bottomConstraint = nil
        }
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: nil, animations: {
            self.alpha = 0
            self.transform = CGAffineTransformMakeTranslation(0, -100)
        }, completion: { finished in
            self.removeFromSuperview()
        })
    }
    
    //MARK: Animations
    func depress() {
        if self.onTap != nil {
            UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: nil, animations: {
                self.transform = CGAffineTransformMakeScale(0.95, 0.95)
                self.alpha = 0.9
            }, completion: nil)
        }
        
    }
    
    func reset() {
        if self.onTap != nil {
            UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: nil, animations: {
                self.transform = CGAffineTransformMakeScale(1, 1)
                self.alpha = 1
            }, completion: nil)
        }
    }
    
    //MARK: Actions
    var onTap: (()->Void)?

}
