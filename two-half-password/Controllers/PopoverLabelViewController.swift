//
//  PopoverLabelViewController.swift
//  two-half-password
//
//  Created by Xinhong LIU on 17/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa

class PopoverLabelViewController: NSViewController {

    var stringValue: String!
    
    @IBOutlet weak var label: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.stringValue = stringValue
    }
    
}
