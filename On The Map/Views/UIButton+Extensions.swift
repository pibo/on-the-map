//
//  UIButtonCorner+Extensions.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 20/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

extension UIButton {
    
    // MARK: - Corner Radius
    
    func cornerRadius(_ amount: CGFloat) {
        layer.cornerRadius = amount
        layer.masksToBounds = true
    }
    
    // MARK: - Enable/Disable
    
    func enabled(_ enabled: Bool) {
        isEnabled = enabled
        alpha = enabled ? 1 : 0.25
    }
}
