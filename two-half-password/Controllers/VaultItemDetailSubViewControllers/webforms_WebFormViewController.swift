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

class webforms_WebFormViewController: VaultItemDetailSubViewController {

    // MARK: views
    
    var _usernameContainerView: NSView!
    var usernameContainerView: NSView! {
        set {
            _usernameContainerView = newValue
        }
        
        get {
            if _usernameContainerView == nil {
                _usernameContainerView = NSView.newAutoLayoutView()
            }
            
            return _usernameContainerView
        }
    }
    
    var _usernameLabel: THLabel!
    var usernameLabel: THLabel! {
        set {
            _usernameLabel = newValue
        }
        
        get {
            if _usernameLabel == nil {
                _usernameLabel = THLabel(forAutoLayout: ())
                _usernameLabel.stringValue = "username:"
                _usernameLabel.alignment = NSTextAlignment.Right
            }
            
            return _usernameLabel
        }
    }
    
    var _usernameField: THTextField!
    var usernameField: THTextField! {
        set {
            _usernameField = newValue
        }
        
        get {
            if _usernameField == nil {
                _usernameField = THTextField(forAutoLayout: ())
            }
            
            return _usernameField
        }
    }
    
    var _usernameCopyButton: THButton!
    var usernameCopyButton: THButton! {
        set {
            _usernameCopyButton = newValue
        }
        
        get {
            if _usernameCopyButton == nil {
                _usernameCopyButton = THButton(forAutoLayout: ())
                _usernameCopyButton.title = "Copy"
                _usernameCopyButton.target = self
                _usernameCopyButton.action = Selector("usernameCopyAction:")
            }
            
            return _usernameCopyButton
        }
    }
    
    var _passwordContainerView: NSView!
    var passwordContainerView: NSView! {
        set {
            _passwordContainerView = newValue
        }
        
        get {
            if _passwordContainerView == nil {
                _passwordContainerView = NSView.newAutoLayoutView()
            }
            
            return _passwordContainerView
        }
    }
    
    var _passwordLabel: THLabel!
    var passwordLabel: THLabel! {
        set {
            _passwordLabel = newValue
        }
        
        get {
            if _passwordLabel == nil {
                _passwordLabel = THLabel(forAutoLayout: ())
                _passwordLabel.stringValue = "password:"
                _passwordLabel.alignment = NSTextAlignment.Right
            }
            
            return _passwordLabel
        }
    }
    
    var _passwordField: THSecureTextField!
    var passwordField: THSecureTextField! {
        set {
            _passwordField = newValue
        }

        get {
            if _passwordField == nil {
                _passwordField = THSecureTextField(forAutoLayout: ())
            }
            
            return _passwordField
        }
    }
    
    var _passwordCopyButton: THButton!
    var passwordCopyButton: THButton! {
        set {
            _passwordCopyButton = newValue
        }
        
        get {
            if _passwordCopyButton == nil {
                _passwordCopyButton = THButton(forAutoLayout: ())
                _passwordCopyButton.title = "Copy"
                _passwordCopyButton.target = self
                _passwordCopyButton.action = Selector("passwordCopyAction:")
            }
            
            return _passwordCopyButton
        }
    }
    
    var _passwordRevealButton: THButton!
    var passwordRevealButton: THButton! {
        set {
            _passwordRevealButton = newValue
        }
        
        get {
            if _passwordRevealButton == nil {
                _passwordRevealButton = THButton(forAutoLayout: ())
                _passwordRevealButton.title = "Reveal"
                _passwordRevealButton.target = self
                _passwordRevealButton.action = Selector("passwordRevealAction:")
            }
            
            return _passwordRevealButton
        }
    }

    var _websiteContainerView: NSView!
    var websiteContainerView: NSView! {
        set {
            _websiteContainerView = newValue
        }
        
        get {
            if _websiteContainerView == nil {
                _websiteContainerView = NSView.newAutoLayoutView()
            }
            
            return _websiteContainerView
        }
    }
    
    var _websiteLabel: THLabel!
    var websiteLabel: THLabel! {
        set {
            _websiteLabel = newValue
        }
        
        get {
            if _websiteLabel == nil {
                _websiteLabel = THLabel(forAutoLayout: ())
                _websiteLabel.stringValue = "website:"
                _websiteLabel.alignment = NSTextAlignment.Right
            }
            
            return _websiteLabel
        }
    }
    
    var _websiteField: THTextField!
    var websiteField: THTextField! {
        set {
            _websiteField = newValue
        }
        
        get {
            if _websiteField == nil {
                _websiteField = THTextField(forAutoLayout: ())
            }
            
            return _websiteField
        }
    }

    var _websiteCopyButton: THButton!
    var websiteCopyButton: THButton! {
        set {
            _websiteCopyButton = newValue
        }
        
        get {
            if _websiteCopyButton == nil {
                _websiteCopyButton = THButton(forAutoLayout: ())
                _websiteCopyButton.title = "Copy"
                _websiteCopyButton.target = self
                _websiteCopyButton.action = Selector("websiteCopyAction:")
            }
            
            return _websiteCopyButton
        }
    }
    
    var _websiteOpenButton: THButton!
    var websiteOpenButton: THButton! {
        set {
            _websiteOpenButton = newValue
        }
        
        get {
            if _websiteOpenButton == nil {
                _websiteOpenButton = THButton(forAutoLayout: ())
                _websiteOpenButton.title = "Open"
                _websiteOpenButton.target = self
                _websiteOpenButton.action = Selector("websiteOpenAction:")
            }
            
            return _websiteOpenButton
        }
    }

    var _noteContainerView: NSView!
    var noteContainerView: NSView! {
        set {
            _noteContainerView = newValue
        }
        
        get {
            if _noteContainerView == nil {
                _noteContainerView = NSView.newAutoLayoutView()
            }
            
            return _noteContainerView
        }
    }
    
    var _noteLabel: THLabel!
    var noteLabel: THLabel! {
        set {
            _noteLabel = newValue
        }
        
        get {
            if _noteLabel == nil {
                _noteLabel = THLabel(forAutoLayout: ())
                _noteLabel.stringValue = "note:"
                _noteLabel.alignment = NSTextAlignment.Right
            }
            
            return _noteLabel
        }
    }
    
    var _noteTextView: THTextView!
    var noteTextView: THTextView! {
        set {
            _noteTextView = newValue
        }
        
        get {
            if _noteTextView == nil {
                _noteTextView = THTextView(forAutoLayout: ())
            }
            
            return _noteTextView
        }
    }
    
    // MARK: HUD
    
    var hud: MBProgressHUD?
    
    func showCopiedHUD() {
        if hud == nil {
            hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
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
    func usernameCopyAction(sender: AnyObject) {
        NSPasteboard.generalPasteboard().clearContents()
        NSPasteboard.generalPasteboard().writeObjects([usernameField.stringValue])
        
        showCopiedHUD()
    }
    
    func passwordCopyAction(sender: AnyObject) {
        NSPasteboard.generalPasteboard().clearContents()
        NSPasteboard.generalPasteboard().writeObjects([passwordField.stringValue])
        
        showCopiedHUD()
    }
    
    func passwordRevealAction(sender: AnyObject) {
        performSegueWithIdentifier("popover", sender: sender)
    }
    
    func websiteCopyAction(sender: AnyObject) {
        NSPasteboard.generalPasteboard().clearContents()
        NSPasteboard.generalPasteboard().writeObjects([websiteField.stringValue])
        
        showCopiedHUD()
    }
    
    func websiteOpenAction(sender: AnyObject) {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: websiteField.stringValue)!)
    }
    
    // MARK: overrides
    
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
        if (dictionary.valueForKey("notesPlain") != nil) {
            let notes = dictionary.valueForKey("notesPlain") as! String
            noteTextView.resetString(notes)
        }
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popover" {
            let popoverViewController = segue.destinationController as! PopoverLabelViewController
            popoverViewController.stringValue = passwordField.stringValue
        }
    }
    
    // MARK: setup views
    
    var didSetup = false
    
    func resetAndSetupViews() {
        // remove 

        usernameContainerView.removeFromSuperview()
        usernameLabel.removeFromSuperview()
        usernameField.removeFromSuperview()
        usernameCopyButton.removeFromSuperview()
        
        passwordContainerView.removeFromSuperview()
        passwordLabel.removeFromSuperview()
        passwordField.removeFromSuperview()
        passwordCopyButton.removeFromSuperview()
        passwordRevealButton.removeFromSuperview()

        websiteContainerView.removeFromSuperview()
        websiteLabel.removeFromSuperview()
        websiteField.removeFromSuperview()
        websiteCopyButton.removeFromSuperview()
        websiteOpenButton.removeFromSuperview()
        
        noteContainerView.removeFromSuperview()
        noteLabel.removeFromSuperview()
        noteTextView.removeFromSuperview()

        // null

        usernameContainerView = nil
        usernameLabel = nil
        usernameField = nil
        usernameCopyButton = nil
        
        passwordContainerView = nil
        passwordLabel = nil
        passwordField = nil
        passwordCopyButton = nil
        passwordRevealButton = nil

        websiteContainerView = nil
        websiteLabel = nil
        websiteField = nil
        websiteCopyButton = nil
        websiteOpenButton = nil

        noteContainerView = nil
        noteLabel = nil
        noteTextView.containerView = nil
        noteTextView = nil
        
        // add back

        view.addSubview(usernameContainerView)
        usernameContainerView.addSubview(usernameLabel)
        usernameContainerView.addSubview(usernameField)
        usernameContainerView.addSubview(usernameCopyButton)
        
        view.addSubview(passwordContainerView)
        passwordContainerView.addSubview(passwordLabel)
        passwordContainerView.addSubview(passwordField)
        passwordContainerView.addSubview(passwordCopyButton)
        passwordContainerView.addSubview(passwordRevealButton)

        view.addSubview(websiteContainerView)
        websiteContainerView.addSubview(websiteLabel)
        websiteContainerView.addSubview(websiteField)
        websiteContainerView.addSubview(websiteCopyButton)
        websiteContainerView.addSubview(websiteOpenButton)

        view.addSubview(noteContainerView)
        noteContainerView.addSubview(noteLabel)
        noteContainerView.addSubview(noteTextView.containerView)
    }
    
    func setupUsernameLayout() {
        usernameContainerView.autoSetDimension(ALDimension.Height, toSize: 40.0)
        usernameContainerView.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        usernameContainerView.autoPinEdgeToSuperviewEdge(ALEdge.Leading)
        usernameContainerView.autoPinEdgeToSuperviewEdge(ALEdge.Trailing)
        
        usernameLabel.autoSetDimension(ALDimension.Width, toSize: 100.0)
        usernameLabel.autoPinEdge(ALEdge.Leading, toEdge: ALEdge.Leading, ofView: usernameContainerView)
        
        usernameField.autoSetDimension(ALDimension.Width, toSize: 180.0)
        usernameField.autoPinEdge(ALEdge.Leading, toEdge: ALEdge.Trailing, ofView: usernameLabel, withOffset: 10.0)
        usernameCopyButton.autoPinEdge(ALEdge.Leading, toEdge: ALEdge.Trailing, ofView: usernameField, withOffset: 10.0)
        
        let subViews: NSArray = [usernameLabel, usernameField, usernameCopyButton]
        for subView in subViews {
            subView.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        }
    }
    
    func setupPasswordLayout() {
        passwordContainerView.autoSetDimension(ALDimension.Height, toSize: 40.0)
        passwordContainerView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: usernameContainerView)
        passwordContainerView.autoPinEdgeToSuperviewEdge(ALEdge.Leading)
        passwordContainerView.autoPinEdgeToSuperviewEdge(ALEdge.Trailing)
        
        passwordLabel.autoSetDimension(ALDimension.Width, toSize: 100.0)
        passwordLabel.autoPinEdge(ALEdge.Leading, toEdge: ALEdge.Leading, ofView: passwordContainerView)
        
        passwordField.autoSetDimension(ALDimension.Width, toSize: 180.0)
        passwordField.autoPinEdge(ALEdge.Leading, toEdge: ALEdge.Trailing, ofView: passwordLabel, withOffset: 10.0)
        passwordCopyButton.autoPinEdge(ALEdge.Leading, toEdge: ALEdge.Trailing, ofView: passwordField, withOffset: 10.0)
        passwordRevealButton.autoPinEdge(ALEdge.Leading, toEdge: ALEdge.Trailing, ofView: passwordCopyButton, withOffset: 10.0)
        
        let subViews: NSArray = [passwordLabel, passwordField, passwordCopyButton, passwordRevealButton]
        for subView in subViews {
            subView.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        }
    }

    func setupWebsiteLayout() {
        websiteContainerView.autoSetDimension(ALDimension.Height, toSize: 40.0)
        websiteContainerView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: passwordContainerView)
        websiteContainerView.autoPinEdgeToSuperviewEdge(ALEdge.Leading)
        websiteContainerView.autoPinEdgeToSuperviewEdge(ALEdge.Trailing)
        
        websiteLabel.autoSetDimension(ALDimension.Width, toSize: 100.0)
        websiteLabel.autoPinEdge(ALEdge.Leading, toEdge: ALEdge.Leading, ofView: websiteContainerView)
        
        websiteField.autoSetDimension(ALDimension.Width, toSize: 180.0)
        websiteField.autoPinEdge(ALEdge.Leading, toEdge: ALEdge.Trailing, ofView: websiteLabel, withOffset: 10.0)
        websiteCopyButton.autoPinEdge(ALEdge.Leading, toEdge: ALEdge.Trailing, ofView: websiteField, withOffset: 10.0)
        websiteOpenButton.autoPinEdge(ALEdge.Leading, toEdge: ALEdge.Trailing, ofView: websiteCopyButton, withOffset: 10.0)
        
        let subViews: NSArray = [websiteLabel, websiteField, websiteCopyButton, websiteOpenButton]
        for subView in subViews {
            subView.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        }
    }

    func setupNoteLayout() {
        noteContainerView.autoSetDimension(ALDimension.Height, toSize: 200.0)
        noteContainerView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: websiteContainerView)
        noteContainerView.autoPinEdgeToSuperviewEdge(ALEdge.Leading)
        noteContainerView.autoPinEdgeToSuperviewEdge(ALEdge.Trailing)

        noteLabel.autoSetDimension(ALDimension.Width, toSize: 100.0)
        noteLabel.autoPinEdge(ALEdge.Leading, toEdge: ALEdge.Leading, ofView: noteContainerView)
        
        noteTextView.containerView.autoSetDimension(ALDimension.Width, toSize: 300.0)
        noteTextView.containerView.autoSetDimension(ALDimension.Height, toSize: 200.0)
        noteTextView.containerView.autoPinEdge(ALEdge.Leading, toEdge: ALEdge.Trailing, ofView: noteLabel, withOffset: 10.0)
        
        // noteTextView.autoPinEdgesToSuperviewEdgesWithInsets(NSEdgeInsetsZero)
        
        let subViews: NSArray = [noteLabel, noteTextView.containerView]
        for subView in subViews {
            subView.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        }
    }
    
    func setupLayouts() {
        setupUsernameLayout()
        setupPasswordLayout()
        setupWebsiteLayout()
        setupNoteLayout()
    }
    
    override func updateViewConstraints() {
        if (!didSetup) {
            resetAndSetupViews()
            setupLayouts()
            didSetup = true
        }
        super.updateViewConstraints()
    }
}
