//
//  ListViewController.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 21/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

class ListViewController: InternalViewController {

    // MARK: Actions
    
    @IBAction func refresh(_ sender: Any) {
        isRefreshing(true)
        DataContainer.shared.refresh { error in
            self.isRefreshing(false)
            if error != nil { self.displayRefreshErrorAlert() }
        }
    }
}
