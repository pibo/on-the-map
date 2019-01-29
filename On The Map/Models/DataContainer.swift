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
    
    // MARK: - Properties
    
    var user: User!
    
    var myStudentLocation: StudentLocation? {
        didSet {
            guard let myStudentLocation = myStudentLocation else { return }
            let notification = oldValue == nil ? DataContainer.didAddMyStudentLocationNotification : DataContainer.didUpdateMyStudentLocationNotification
            NotificationCenter.default.post(
                name: notification,
                object: self,
                userInfo: [DataContainer.myStudentLocationKey: myStudentLocation]
            )
        }
    }
    
    var otherStudentLocations: [StudentLocation] = [] {
        didSet {
            NotificationCenter.default.post(
                name: DataContainer.didChangeOtherStudentLocationsNotification,
                object: self,
                userInfo: [DataContainer.otherStudentLocationsKey: otherStudentLocations]
            )
        }
    }
    
    // MARK: - Notifications
    
    static let didChangeOtherStudentLocationsNotification = Notification.Name("didChangeOtherStudentLocationsNotification")
    static let didAddMyStudentLocationNotification = Notification.Name("didAddMyStudentLocationNotification")
    static let didUpdateMyStudentLocationNotification = Notification.Name("didUpdateMyStudentLocationNotification")
    
    // MARK: - UserInfo Keys
    
    static let myStudentLocationKey = "myStudentLocation"
    static let otherStudentLocationsKey = "otherStudentLocations"
    
    // MARK: - Shared Instance
    
    class var shared: DataContainer {
        struct Singleton {
            static var sharedInstance = DataContainer()
        }
        
        return Singleton.sharedInstance
    }
    
    // MARK: - Methods
    
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
            
            self.getMyStudentLocation(completionHandler: completionHandler)
        }
    }
    
    func getStudentLocations(completionHandler: @escaping CompletionHandler) {
        Parse.get { otherStudentLocations, error in
            if let error = error {
                completionHandler(error)
            } else {
                let myLocation: (StudentLocation) -> Bool = { $0.uniqueKey != self.user.id }
                let emptyCoordinate: (StudentLocation) -> Bool = { $0.latitude != nil && $0.longitude != nil }
                let emptyStrings: (StudentLocation) -> Bool = {
                    !$0.uniqueKey.isEmpty &&
                    !$0.firstName.isEmpty &&
                    !$0.lastName.isEmpty &&
                    !$0.mediaURL.isEmpty &&
                    !$0.mapString.isEmpty
                }
                
                self.otherStudentLocations = otherStudentLocations!.filter(emptyStrings).filter(emptyCoordinate).filter(myLocation)
                
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
