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
    
    var id: String!
    var user: User?
    var studentLocations: [StudentLocation] = []
    var myStudentLocation: StudentLocation?
    
    // MARK: Shared Instance
    
    class var shared: DataContainer {
        struct Singleton {
            static var sharedInstance = DataContainer()
        }
        
        return Singleton.sharedInstance
    }
    
    // MARK: Methods
    
    func refresh(completionHandler: @escaping CompletionHandler) {
        getUser(completionHandler: completionHandler)
    }
    
    private func getUser(completionHandler: @escaping CompletionHandler) {
        Udacity.getUser(id: id) { user, error in
            if let error = error {
                completionHandler(error)
            } else {
                self.user = user
                self.getStudentLocations(completionHandler: completionHandler)
            }
        }
    }
    
    private func getStudentLocations(completionHandler: @escaping CompletionHandler) {
        Parse.get { studentLocations, error in
            if let error = error {
                completionHandler(error)
            } else {
                self.studentLocations = studentLocations!.filter {
                    $0.uniqueKey != self.id &&
                    $0.latitude != nil &&
                    $0.longitude != nil
                }
                
                self.getMyStudentLocation(completionHandler: completionHandler)
            }
        }
    }
    
    private func getMyStudentLocation(completionHandler: @escaping CompletionHandler) {
        Parse.get(id: id) { (myStudentLocation, error) in
            if let error = error {
                completionHandler(error)
            } else {
                self.myStudentLocation = myStudentLocation
                
                if let myStudentLocation = myStudentLocation {
                    self.studentLocations.insert(myStudentLocation, at: 0)
                }
                
                completionHandler(nil)
                
                // Notify everyone that we have fresh data.
                NotificationCenter.default.post(name: UIApplication.didRefreshDataContainerNotification, object: self)
            }
        }
    }
}

// MARK: Notification Name

extension UIApplication {
    public static let didRefreshDataContainerNotification = Notification.Name("UIApplicationDidRefreshDataContainerNotification")
}
