//
//  VaultItemDetailViewController.swift
//  two-half-password
//
//  Created by Xinhong LIU on 15/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa

class VaultItemDetailViewController: NSViewController {

    var item: VaultItem?
    
    @IBOutlet var jsonDumpField: NSTextView!
    @IBOutlet weak var titleField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func showItem(item: VaultItem?) {
        self.item = item
        
        guard (item != nil) else {
            // hide everything
            titleField.hidden = true
            return
        }
        
        titleField.hidden = false
        
        do {
            titleField.stringValue = item!.title
            let info = try item?.info()
            let dictionary = info?.valueForKey("decrypted") as! NSDictionary
            jsonDumpField.string = "\(dictionary)"
        } catch {
            // TODO: catch errors
        }
        
        
    }
    
}
