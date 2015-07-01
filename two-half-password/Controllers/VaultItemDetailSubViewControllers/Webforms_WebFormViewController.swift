//
//  webforms_WebFormViewController.swift
//  two-half-password
//
//  Created by Xinhong LIU on 17/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa
import SwiftyTimer
import PureLayout

class Webforms_WebFormViewController: VaultItemDetailSubViewController {

    
    
    
    @IBOutlet weak var usernameField: NSTextField!
    @IBOutlet weak var usernameCopyButton: NSButton!
    
    
    @IBOutlet weak var passwordField: NSSecureTextField!
    @IBOutlet weak var passwordRevealButton: NSButton!
    @IBOutlet weak var passwordCopyButton: NSButton!
    
    
    @IBOutlet weak var websiteField: NSTextField!
    
    
    @IBOutlet weak var websiteOpenButton: NSButton!
    @IBOutlet weak var websiteCopyButton: NSButton!
    
    @IBOutlet var noteTextView: NSTextView!
    
    
    // MARK: HUD
    
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
    
    // MARK: User Actions
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
        performSegueWithIdentifier("popover", sender: sender)
    }
    
    @IBAction func websiteCopyAction(sender: AnyObject) {
        NSPasteboard.generalPasteboard().clearContents()
        NSPasteboard.generalPasteboard().writeObjects([websiteField.stringValue])
        
        showCopiedHUD()
    }
    
    @IBAction func websiteOpenAction(sender: AnyObject) {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: websiteField.stringValue)!)
    }
    
    // user did change the text
    func didChangeFields() {
        resetButton.hidden = false
        saveButton.hidden = false
    }
    
    override func controlTextDidChange(obj: NSNotification) {
        didChangeFields()
    }
    
    func textDidChange(notification: NSNotification) {
        didChangeFields()
    }
    
    // MARK: overrides
    
    override func clearFields() {
        super.clearFields()
        
        usernameField.stringValue = ""
        passwordField.stringValue = ""
        websiteField.stringValue = ""
        noteTextView.string = ""
    }
    
    override func displayInfo() {
        super.displayInfo()
        
        // fields
        let fields = dictionaryCache.valueForKey("fields") as! NSArray
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
        if (dictionaryCache.valueForKey("URLs") != nil) {
            let urls = dictionaryCache.valueForKey("URLs") as! NSArray
            if urls.count > 0 {
                let firstURL = urls[0] as! NSDictionary
                let urlString = firstURL.valueForKey("url") as! String
                if urlString.rangeOfString("http")?.startIndex == urlString.startIndex {
                    websiteField.stringValue = urlString
                } else {
                    websiteField.stringValue = "https://\(urlString)"
                }
            }
        } else {
            websiteField.stringValue = "no specified"
        }
        
        // note
        noteTextView.string = ""
        if (dictionaryCache.valueForKey("notesPlain") != nil) {
            let notes = dictionaryCache.valueForKey("notesPlain") as! String
            noteTextView.string = notes
        }
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popover" {
            let popoverViewController = segue.destinationController as! PopoverLabelViewController
            popoverViewController.stringValue = passwordField.stringValue
        }
    }
    
}
