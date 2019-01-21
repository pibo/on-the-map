//
//  InternalViewController.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 21/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

class InternalViewController: UIViewController {
    
    // MARK: Actions
    @IBAction func signOut(_ sender: Any) {
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out? You have to provide an e-mail and password to sign in again.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let signOut = UIAlertAction(title: "Sign Out", style: .destructive) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancel)
        alert.addAction(signOut)
        
        present(alert, animated: true, completion: nil)
    }
}
