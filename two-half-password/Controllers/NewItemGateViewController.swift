//
//  NewItemGateViewController.swift
//  two-half-password
//
//  Created by Xinhong LIU on 30/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa

class NewItemGateViewController: NSViewController {

    
    @IBAction func newItem(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("newItem", object: "webforms.WebForm")
        
    }
    
}
