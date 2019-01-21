//
//  LoginViewController.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 14/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var activityView: UIActivityIndicatorView!
    
    // MARK: Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRoundedBorders()
    }
    
    // MARK: Methods

    func setupRoundedBorders() {
        emailTextField.padding(left: 4, right: 4)
        emailTextField.borderStyle = .roundedRect
        
        passwordTextField.padding(left: 4, right: 4)
        passwordTextField.borderStyle = .roundedRect
        
        loginButton.cornerRadius(4)
    }
    
    func isLoading(_ loading: Bool) {
        if loading {
            loginButton.isHidden = true
            activityView.startAnimating()
        } else {
            loginButton.isHidden = false
            activityView.stopAnimating()
        }
    }
    
    func handleLoginCompletion(id: String?, error: Error?) {
        if let error = error {
            handleLoginError(error: error)
        } else if let id = id {
            handleLoginSuccess(id: id)
        }
    }
    
    func handleLoginSuccess(id: String) {
        DataContainer.shared.id = id
        DataContainer.shared.refresh() { error in
            self.isLoading(false)
            self.passwordTextField.text = ""
            self.performSegue(withIdentifier: "LoginSuccessful", sender: nil)
        }
    }
    
    func handleLoginError(error: Error) {
        let title, message: String
        
        if let error = error as? APIError, error.status == 403 {
            title = "Wrong combination"
            message = "The provided crendentials are invalid. Please try again!"
        } else {
            title = "Error"
            message = "An error ocurred. Please try again in a moment!"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            self.passwordTextField.text = ""
            self.passwordTextField.becomeFirstResponder()
        }
        
        alert.addAction(action)
        
        present(alert, animated: true) { self.isLoading(false) }
    }
    
    // MARK: Actions
    
    @IBAction func login(_ sender: Any) {
        isLoading(true)
        let username = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Udacity.login(username: username, password: password, completionHandler: handleLoginCompletion(id:error:))
    }
    
    @IBAction func signUp(_ sender: Any) {
        UIApplication.shared.open(Udacity.Endpoints.signUp, options: [:], completionHandler: nil)
    }
}

// MARK: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            login(textField)
        default: break
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            loginButton.isEnabled = false
            loginButton.alpha = 0.25
        } else {
            loginButton.isEnabled = true
            loginButton.alpha = 1
        }
        
        return true
    }
}
