//
//  VaultItem.swift
//  two-half-password
//
//  Created by Xinhong LIU on 15/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa

class VaultItem: NSObject {
    var identifier: String!
    var type: String!
    var title: String!
    var urlString: String!
    
    init(array: NSArray) throws {
        identifier = array[0] as! String
        type = array[1] as! String
        title = array[2] as! String
        urlString = array[3] as! String
    }
}
