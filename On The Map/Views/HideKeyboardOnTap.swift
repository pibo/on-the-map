//
//  HideKeyboardOnTap.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 29/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
