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
    
    private var _REF_BASE = Firebase(url: "https://facetube.firebaseio.com")
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
}
