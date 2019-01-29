//
//  DataController.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 21/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation
import UIKit

class DataController {
    
    typealias CompletionHandler = (Error?) -> Void
    
    // MARK: - Properties
    
    var user: User!
    
    var myStudentLocation: StudentLocation? {
        didSet {
            guard let myStudentLocation = myStudentLocation else { return }
            let notification = oldValue == nil ? DataController.didAddMyStudentLocationNotification : DataController.didUpdateMyStudentLocationNotification
            NotificationCenter.default.post(
                name: notification,
                object: self,
                userInfo: [DataController.myStudentLocationKey: myStudentLocation]
            )
        }
    }
    
    var otherStudentLocations: [StudentLocation] = [] {
        didSet {
            NotificationCenter.default.post(
                name: DataController.didChangeOtherStudentLocationsNotification,
                object: self,
                userInfo: [DataController.otherStudentLocationsKey: otherStudentLocations]
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
    
    class var shared: DataController {
        struct Singleton {
            static var sharedInstance = DataController()
        }
        
        return Singleton.sharedInstance
    }
    
    // MARK: - Methods
    
    func getUser(id: String, completion: @escaping CompletionHandler) {
        Udacity.getUser(id: id) { user, error in
            if let error = error {
                completion(error)
            } else {
                self.user = user
                completion(nil)
            }
        }
    }
    
    func refresh(completion: @escaping CompletionHandler) {
        getStudentLocations { error in
            if let error = error {
                completion(error)
                return
            }
            
            self.getMyStudentLocation(completion: completion)
        }
    }
    
    func getStudentLocations(completion: @escaping CompletionHandler) {
        Parse.get { otherStudentLocations, error in
            if let error = error {
                completion(error)
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
                
                completion(nil)
            }
        }
    }
    
    func getMyStudentLocation(completion: @escaping CompletionHandler) {
        Parse.get(id: user.id) { (myStudentLocation, error) in
            if let error = error {
                completion(error)
            } else {
                self.myStudentLocation = myStudentLocation
                completion(nil)
            }
        }
    }
}
