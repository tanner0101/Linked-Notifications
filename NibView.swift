//
//  NibView.swift
//  Decode
//
//  Created by Tanner Nelson on 4/2/15.
//  Copyright (c) 2015 Blue Bite. All rights reserved.
//

import UIKit

class NibView: UIView {

    class func instantiate(nibName: String) -> UIView {
        var view = UIView()
        
        var elements = NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil)
        for element in elements {
            if let element = element as? UIView {
                return element
            }
        }
        
        return view
    }

}
