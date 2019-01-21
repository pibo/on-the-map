//
//  ListViewController.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 21/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

class ListViewController: InternalViewController {
    
    // MARK: Outlets
    
    @IBOutlet var tableView: UITableView!

    // MARK: Actions
    
    @IBAction func refresh(_ sender: Any) {
        isRefreshing(true)
        DataContainer.shared.refresh { error in
            self.isRefreshing(false)
            
            if error != nil {
                self.displayRefreshErrorAlert()
            } else {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataContainer.shared.studentLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationCell")!
        let studentLocation = DataContainer.shared.studentLocations[indexPath.row]
        
        cell.textLabel?.text = studentLocation.fullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "No Name" : studentLocation.fullName
        cell.detailTextLabel?.text = studentLocation.mediaURL
        
        cell.imageView?.image = UIImage(named: "Pin")!.withRenderingMode(.alwaysTemplate)
        cell.imageView?.tintColor = UIColor(named: "Primary Blue")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentLocation = DataContainer.shared.studentLocations[indexPath.row]
        let url = URL(string: studentLocation.mediaURL)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
