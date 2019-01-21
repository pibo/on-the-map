//
//  UIButtonCornerRadius.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 20/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

extension UIButton {
    
    func cornerRadius(_ amount: CGFloat) {
        layer.cornerRadius = amount
        layer.masksToBounds = true
    }
}
