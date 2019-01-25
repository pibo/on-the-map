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
    
    // MARK: Notification Related Methods

    @objc override func didChangeOtherStudentLocations(_ notification: Notification) {
        tableView.reloadData()
    }
    
    @objc override func didAddMyStudentLocation(_ notification: Notification) {
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }
    
    @objc override func didUpdateMyStudentLocation(_ notification: Notification) {
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let container = DataContainer.shared
        var count = container.otherStudentLocations.count
        
        if container.myStudentLocation != nil {
            count += 1
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationCell")!
        var studentLocation = DataContainer.shared.otherStudentLocations[indexPath.row]
        var pinColor = UIColor(named: "Primary Blue")!
        
        if let myLocation = DataContainer.shared.myStudentLocation {
            if indexPath.row == 0 {
                studentLocation = myLocation
                pinColor = UIColor(named: "Primary Red")!
            } else {
                studentLocation = DataContainer.shared.otherStudentLocations[indexPath.row - 1]
            }
        }
        
        cell.textLabel?.text = studentLocation.fullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "No Name" : studentLocation.fullName
        cell.detailTextLabel?.text = studentLocation.mediaURL
        cell.imageView?.image = UIImage(named: "Pin")!.withRenderingMode(.alwaysTemplate)
        cell.imageView?.tintColor = pinColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var studentLocation = DataContainer.shared.otherStudentLocations[indexPath.row]
        
        if let myLocation = DataContainer.shared.myStudentLocation {
            studentLocation = indexPath.row == 0 ? myLocation : DataContainer.shared.otherStudentLocations[indexPath.row - 1]
        }
        
        let url = URL(string: studentLocation.mediaURL)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
}
