//
//  AuthViewController.swift
//  two-half-password
//
//  Created by Xinhong LIU on 14/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa

class AuthViewController: NSViewController {
    
    weak var mainViewController: MainViewController?
    
    @IBOutlet weak var passwordField: NSSecureTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func authenticate(sender: AnyObject) {
        let password = passwordField.stringValue
        
        if !mainViewController!.unlockVault(password) {
            // alert
        }
    }
    
}
