//
//  DataContainer.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 21/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

class DataContainer {
    
    typealias CompletionHandler = (Error?) -> Void
    
    // MARK: Properties
    
    var id: String!
    var user: User?
    var studentLocations: [StudentLocation]?
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
                self.studentLocations = studentLocations
                completionHandler(nil)
            }
        }
    }
    
    private func getMyStudentLocation(completionHandler: @escaping CompletionHandler) {
        Parse.get(id: id) { (myStudentLocation, error) in
            if let error = error {
                completionHandler(error)
            } else {
                self.myStudentLocation = myStudentLocation
                completionHandler(nil)
            }
        }
    }
}
