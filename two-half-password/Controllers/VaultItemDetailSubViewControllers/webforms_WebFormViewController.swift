//
//  webforms_WebFormViewController.swift
//  two-half-password
//
//  Created by Xinhong LIU on 17/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa
import SwiftyTimer

class webforms_WebFormViewController: VaultItemDetailSubViewController {

    @IBOutlet weak var usernameField: NSTextField!
    @IBOutlet weak var passwordField: NSSecureTextField!
    @IBOutlet weak var passwordRevealButton: NSButton!
    @IBOutlet weak var websiteField: NSTextField!
    
    var hud: MBProgressHUD?
    
    func showCopiedHUD() {
        if hud == nil {
            hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud?.mode = MBProgressHUDModeText
            hud?.labelText = "Copied to clipboard"
        } else {
            hud?.show(true)
        }
        
        NSTimer.after(1.second) {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                hud?.hide(true)
            })
        }
    }
    
    @IBAction func usernameCopyAction(sender: AnyObject) {
        NSPasteboard.generalPasteboard().clearContents()
        NSPasteboard.generalPasteboard().writeObjects([usernameField.stringValue])
        
        showCopiedHUD()
    }
    
    @IBAction func passwordCopyAction(sender: AnyObject) {
        NSPasteboard.generalPasteboard().clearContents()
        NSPasteboard.generalPasteboard().writeObjects([passwordField.stringValue])
        
        showCopiedHUD()
    }
    
    @IBAction func passwordRevealAction(sender: AnyObject) {
        
    }
    
    override func displayInfo(dictionary: NSDictionary) {
        // fields
        let fields = dictionary.valueForKey("fields") as! NSArray
        for field in fields {
            let name = (field as! NSDictionary).valueForKey("name") as! String
            let value = (field as! NSDictionary).valueForKey("value") as! String
            if name == "password" {
                passwordField.stringValue = value
            } else if name == "username" {
                usernameField.stringValue = value
            }
        }
        
        // url, only showing one
        if (dictionary.valueForKey("URLs") != nil) {
            let urls = dictionary.valueForKey("URLs") as! NSArray
            if urls.count > 0 {
                let firstURL = urls[0] as! NSDictionary
                let urlString = firstURL.valueForKey("url") as! String
                let link = NSMutableAttributedString(string: urlString)
                link.addAttribute(NSLinkAttributeName, value: urlString, range: NSMakeRange(0, link.length))
                websiteField.attributedStringValue = link
            }
        } else {
            websiteField.stringValue = "no specified"
        }
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popover" {
            let popoverViewController = segue.destinationController as! PopoverLabelViewController
            popoverViewController.stringValue = passwordField.stringValue
        }
    }
}
