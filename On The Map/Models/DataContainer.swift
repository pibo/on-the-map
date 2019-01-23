//
//  DataContainer.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 21/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation
import UIKit

class DataContainer {
    
    typealias CompletionHandler = (Error?) -> Void
    
    // MARK: Properties
    
    var user: User!
    var myStudentLocation: StudentLocation?
    var studentLocations: [StudentLocation] = [] {
        // Notify everyone that we have fresh data.
        didSet {
            NotificationCenter.default.post(name: UIApplication.didUpdateDataContainerNotification, object: self)
        }
    }
    
    // MARK: Shared Instance
    
    class var shared: DataContainer {
        struct Singleton {
            static var sharedInstance = DataContainer()
        }
        
        return Singleton.sharedInstance
    }
    
    // MARK: Methods
    
    func getUser(id: String, completionHandler: @escaping CompletionHandler) {
        Udacity.getUser(id: id) { user, error in
            if let error = error {
                completionHandler(error)
            } else {
                self.user = user
                completionHandler(nil)
            }
        }
    }
    
    func refresh(completionHandler: @escaping CompletionHandler) {
        getStudentLocations { error in
            if let error = error {
                completionHandler(error)
                return
            }
            
            self.getMyStudentLocation { error in
                if let error = error {
                    completionHandler(error)
                    return
                }
                
                // Prepend my location to all locations array.
                if let myStudentLocation = self.myStudentLocation {
                    self.studentLocations.insert(myStudentLocation, at: 0)
                }
                
                completionHandler(nil)
            }
        }
    }
    
    func getStudentLocations(completionHandler: @escaping CompletionHandler) {
        Parse.get { studentLocations, error in
            if let error = error {
                completionHandler(error)
            } else {
                let myLocation: (StudentLocation) -> Bool = { $0.uniqueKey != self.user.id }
                let emptyCoordinate: (StudentLocation) -> Bool = { $0.latitude != nil && $0.longitude != nil }
                
                self.studentLocations = studentLocations!.filter(emptyCoordinate).filter(myLocation)
                
                completionHandler(nil)
            }
        }
    }
    
    func getMyStudentLocation(completionHandler: @escaping CompletionHandler) {
        Parse.get(id: user.id) { (myStudentLocation, error) in
            if let error = error {
                completionHandler(error)
            } else {
                self.myStudentLocation = myStudentLocation
                completionHandler(nil)
            }
        }
    }
}

// MARK: Notification Name

extension UIApplication {
    public static let didUpdateDataContainerNotification = Notification.Name("UIApplicationDidUpdateDataContainerNotification")
}
