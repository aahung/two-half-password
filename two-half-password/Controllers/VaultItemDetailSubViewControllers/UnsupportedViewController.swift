//
//  UnsupportedViewController.swift
//  two-half-password
//
//  Created by Xinhong LIU on 17/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa

class UnsupportedViewController: VaultItemDetailSubViewController {

    
    @IBOutlet weak var rawJSONScrollView: NSScrollView!
    
    override func displayInfo() {
        super.displayInfo()
    
        let rawJSONTextView = rawJSONScrollView.contentView.documentView as! NSTextView
        
        rawJSONTextView.string = "\(dictionaryCache)"
        
    }
    
}
