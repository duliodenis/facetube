//
//  DataService.swift
//  FaceTube
//
//  Created by Dulio Denis on 12/14/15.
//  Copyright © 2015 Dulio Denis. All rights reserved.
//

import Foundation
import Firebase


class DataService {
    static let ds = DataService()
    
    private var _REF_BASE  = Firebase(url: "\(URL_BASE)")
    private var _REF_POSTS = Firebase(url: "\(URL_BASE)/posts")
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")
    
    
    // MARK: Accessors
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_POSTS: Firebase {
        return _REF_POSTS
    }
    
    var REF_USERS: Firebase {
        return _REF_USERS
    }
    
    
    // MARK: User Creation
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>) {
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
}
