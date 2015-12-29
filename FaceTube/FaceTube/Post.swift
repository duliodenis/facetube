//
//  Post.swift
//  FaceTube
//
//  Created by Dulio Denis on 12/24/15.
//  Copyright © 2015 Dulio Denis. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _postDescription: String!
    private var _imageURL: String?
    private var _likes: Int!
    private var _username: String!
    private var _postKey: String!
    
    private var _postReference: Firebase!
    
    var postDescription: String {
        return _postDescription
    }
    
    var imageURL: String? {
        return _imageURL
    }
    
    var likes: Int {
        return _likes
    }
    
    var username: String {
        return _username
    }
    
    var postKey: String {
        return _postKey
    }
    
    
    // MARK: Initializer used when we create a post
    
    init(description: String, imageURL: String?, username: String) {
        self._postDescription = description
        self._imageURL = imageURL
        self._username = username
    }
    
    
    // MARK: Initializer used to convert data we get from Firebase
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let likes = dictionary["likes"] as? Int {
            self._likes = likes
        }
        
        if let imageURL = dictionary["imageURL"] as? String {
            self._imageURL = imageURL
        }
        
        if let description = dictionary["description"] as? String {
            self._postDescription = description
        }
        
        self._postReference = DataService.ds.REF_POSTS.childByAppendingPath(self._postKey)
    }
    
    
    // MARK: Like Updater
    
    func updateLikes(addLike: Bool) {
        if addLike {
            _likes = _likes + 1
        } else {
            _likes = _likes - 1
        }
        
        _postReference.childByAppendingPath("likes").setValue(_likes)
    }
}