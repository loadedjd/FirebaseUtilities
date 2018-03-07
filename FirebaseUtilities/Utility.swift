//
//  Utility.swift
//  FirebaseUtilities
//
//  Created by Jared Williams on 3/6/18.
//  Copyright © 2018 Jared Williams. All rights reserved.
//

import Foundation
import Firebase


class Utility {
    
    
    
    
    /**
        Loads arbitrary data from Firebase real-time database
     

        - parameter ref: A reference to a Firebase real-time database child
        - parameter path: The relative path to the resource
        - parameter completion: Completion block to be run after the data has been retrieved
 
 
     **/
    static func getArbitraryDataFrom(ref: DatabaseReference, path: String, completion: ((Any?)->())?) {
        ref.child(path).observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            completion?(snapshot.value)
        }
    }
    
    
    
    /**
        Loads a string dictionary from the given database reference
     
        - parameter ref: A reference to a Firebase real-time database child
        - parameter path: The relative path to the resource
        - parameter completion: Completion block to be run after the data has been retrieved
     
     **/
    
    func getDictionaryFromRemote(ref: DatabaseReference, path: String, completion: (([String: String]?)->())?) {
        
        Utility.getArbitraryDataFrom(ref: ref, path: path) { (data: Any?) in
            if let unwrappedData = data as? [String : String] {
                completion?(unwrappedData)
            } else {
                completion?(nil)
            }
        }
    }
    
    
    /**
        Sends a String to String array to the real-time database, and either overrwrites the existing data or adds a new child with a random ID
     
        - parameter ref: A reference to a Firebase real-time database child
        - parameter data: A String to String array to be pushed to ref
        - parameter path: The relative path to the resource
        - parameter autoId: A Bool indicating whether or not the existing data should be overwritten
 
    **/
    
    func pushDictionaryToRemote(ref: DatabaseReference, data: [String : String], path: String,  autoId: Bool) {
        
        if autoId {
            ref.child(path).childByAutoId().setValue(data)
        } else {
            ref.child(path).setValue(data)
        }
        
    }
}
