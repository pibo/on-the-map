//
//  SignInViewController.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 14/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
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
        
        signInButton.cornerRadius(4)
    }
    
    func isLoading(_ loading: Bool) {
        if loading {
            signInButton.isHidden = true
            activityView.startAnimating()
        } else {
            signInButton.isHidden = false
            activityView.stopAnimating()
        }
    }
    
    func handleSignInCompletion(id: String?, error: Error?) {
        if let error = error {
            handleSignInError(error: error)
        } else if let id = id {
            handleSignInSuccess(id: id)
        }
    }
    
    func handleSignInSuccess(id: String) {
        DataContainer.shared.id = id
        DataContainer.shared.refresh() { error in
            self.isLoading(false)
            self.passwordTextField.text = ""
            self.performSegue(withIdentifier: "SignInSuccessful", sender: nil)
        }
    }
    
    func handleSignInError(error: Error) {
        let title, message: String
        
        if let error = error as? APIError, error.status == 403 {
            title = Strings.InvalidCredentials.title
            message = Strings.InvalidCredentials.message
        } else {
            title = Strings.Error.title
            message = Strings.Error.message
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
    
    @IBAction func signIn(_ sender: Any) {
        isLoading(true)
        let username = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Udacity.signIn(username: username, password: password, completionHandler: handleSignInCompletion(id:error:))
    }
    
    @IBAction func signUp(_ sender: Any) {
        UIApplication.shared.open(Udacity.Endpoints.signUp, options: [:], completionHandler: nil)
    }
}

// MARK: UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            signIn(textField)
        default: break
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            signInButton.isEnabled = false
            signInButton.alpha = 0.25
        } else {
            signInButton.isEnabled = true
            signInButton.alpha = 1
        }
        
        return true
    }
}
