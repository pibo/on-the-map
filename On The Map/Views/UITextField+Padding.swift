//
//  UITextField+Padding.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 20/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

extension UITextField {
    
    func padding(left: CGFloat, right: CGFloat) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: frame.size.height))
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: frame.size.height))
        
        leftView = leftPaddingView
        leftViewMode = .always
        
        rightView = rightPaddingView
        rightViewMode = .always
    }
}
