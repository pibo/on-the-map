//
//  KeyboardAwareViewController.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 29/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

class KeyboardAwareViewController: UIViewController {
    
    // MARK: - - Configuration
    
    let keyboardOffset: CGFloat = 32.0
    let animationDuration: TimeInterval = 0.3
    
    // MARK: - - Properties
    
    var awareTextFields: [UITextField]!
    var keyboardObservers: [Any] = []
    var textFieldObservers: [Any] = []
    var keyboardHeight: CGFloat?
    
    // MARK: - - Life Cycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        destroyObservers()
    }
    
    // MARK: - - Helper Methods
    
    private func createKeyboardObserver() {
        let willShowObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main, using: { notification in
            if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                self.keyboardHeight = keyboardSize.cgRectValue.height
                if let activeTextField = self.awareTextFields.first(where: { $0.isEditing }) {
                    self.adjustView(for: activeTextField)
                }
            }
        })
        
        let willHideObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main, using: { _ in
            self.keyboardHeight = nil
            self.adjustView(y: 0)
        })
        
        keyboardObservers.append(contentsOf: [willShowObserver, willHideObserver])
    }
    
    private func destroyObservers() {
        keyboardObservers.forEach { NotificationCenter.default.removeObserver($0) }
        textFieldObservers.forEach { NotificationCenter.default.removeObserver($0) }
    }
    
    private func calculateOffset(for textField: UITextField) -> CGFloat {
        guard let keyboardHeight = keyboardHeight else { return 0.0 }
        let visibleArea = view.frame.height - keyboardHeight
        let textFieldLimit = textField.superview!.convert(textField.frame.origin, to: nil).y + textField.frame.height
        
        guard textFieldLimit >= visibleArea else { return 0.0 }
        
        return visibleArea - textFieldLimit - keyboardOffset
    }
    
    private func adjustView(for textField: UITextField) {
        adjustView(y: calculateOffset(for: textField))
    }
    
    private func adjustView(y: CGFloat) {
        UIView.animate(withDuration: animationDuration) { self.view.frame.origin.y = y }
    }
    
    // MARK: - - Public API
    
    func adjustView(for textFields: [UITextField]) {
        awareTextFields = textFields
        textFieldObservers = textFields.map { textField in
            NotificationCenter.default.addObserver(forName: UITextField.textDidBeginEditingNotification, object: textField, queue: .main, using: { _ in
                if self.keyboardHeight != nil {
                    self.adjustView(for: textField)
                }
            })
        }
    }
}
