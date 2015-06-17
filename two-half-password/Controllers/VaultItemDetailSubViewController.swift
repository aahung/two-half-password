//
//  VaultItemDetailSubViewController.swift
//  two-half-password
//
//  Created by Xinhong LIU on 16/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa

class VaultItemDetailSubViewController: NSViewController {

    // MARK: webforms.WebForm
    
    
    
    // MARK: unsupported types
    // @IBOutlet weak var rawJSONTextView: NSTextView!
    
    var item: VaultItem!
    
    func displayInfo(dictionary: NSDictionary) {
        
    }
    
    func loadItem(item: VaultItem) {
        self.item = item
        var info: NSDictionary!
        do {
            info = try item.info()
        } catch {
            // TODO: catch errors
        }
        let dictionary = info.valueForKey("decrypted") as! NSDictionary
        displayInfo(dictionary)
    }
    
}
