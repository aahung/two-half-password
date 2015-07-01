//
//  VaultItemDetailSubViewController.swift
//  two-half-password
//
//  Created by Xinhong LIU on 16/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa
import PureLayout

class VaultItemDetailSubViewController: NSViewController, NSTextFieldDelegate, NSTextViewDelegate {

    // MARK: webforms.WebForm
    
    
    
    // MARK: unsupported types
    // @IBOutlet weak var rawJSONTextView: NSTextView!
    
    var item: VaultItem? {
        didSet {
            viewDidAppear()
        }
    }
    var dictionaryCache: NSDictionary!
    
    func newItem(notification: NSNotification) {
        print(notification)
    }
    
    
    var willLoadItem = false

    override func viewDidAppear() {
        if (item != nil) {
            loadItem()
        } else {
            clearFields()
        }
    }
    
    func clearFields() {
        titleField.stringValue = ""
    }
    
    func displayInfo() {
        // hide edit buttons when no changes made
        resetButton.hidden = true
        saveButton.hidden = true
        
        titleField.stringValue = item!.title
    }
    
    func loadItem() {
        var info: NSDictionary!
        do {
            info = try item!.info()
        } catch {
            // TODO: catch errors
        }
        let dictionary = info.valueForKey("decrypted") as! NSDictionary
        dictionaryCache = dictionary
        
        willLoadItem = true;
        displayInfo()
    }
    
    // MARK: views
    
    var _titleField: THTextField!
    var titleField: THTextField! {
        set {
            _titleField = newValue
        }
        
        get {
            if _titleField == nil {
                _titleField = THTextField(forAutoLayout: ())
                _titleField.placeholderString = "Item title"
                _titleField.font = NSFont.systemFontOfSize(20.0)
                _titleField.autoRemoveConstraintsAffectingView()
                _titleField.autoSetDimension(ALDimension.Height, toSize: 28.0)
                _titleField.bordered = false
                _titleField.drawsBackground = false
                _titleField.delegate = self
            }
            
            return _titleField
        }
    }
    
    var _resetButton: THButton!
    var resetButton: THButton! {
        set {
            _resetButton = newValue
        }
        
        get {
            if _resetButton == nil {
                _resetButton = THButton(forAutoLayout: ())
                _resetButton.title = "Reset"
                _resetButton.target = self
                _resetButton.action = Selector("viewDidAppear")
            }
            
            return _resetButton
        }
    }
    
    var _saveButton: THButton!
    var saveButton: THButton! {
        set {
            _saveButton = newValue
        }
        
        get {
            if _saveButton == nil {
                _saveButton = THButton(forAutoLayout: ())
                _saveButton.title = "Save"
            }
            
            return _saveButton
        }
    }
    
    // MARK: setup views
    
    var didSetup = false
    
    func resetAndSetupViews() {
        // remove
        
        titleField.removeFromSuperview()
        
        
        resetButton.removeFromSuperview()
        saveButton.removeFromSuperview()
        
        // null
        
        titleField = nil
        
        
        resetButton = nil
        saveButton = nil
        // add back
        
        view.addSubview(titleField)
        
        
        view.addSubview(resetButton)
        view.addSubview(saveButton)
    }
    
    func setupTitleLayout() {
        titleField.autoSetDimension(ALDimension.Width, toSize: 200.0)
        titleField.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        titleField.autoPinEdgeToSuperviewEdge(ALEdge.Leading, withInset: 100.0)
    }
    
    
    func setupEditLayout() {
        saveButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom)
        saveButton.autoPinEdgeToSuperviewEdge(ALEdge.Trailing)
        saveButton.autoPinEdge(ALEdge.Leading, toEdge: ALEdge.Trailing, ofView: resetButton, withOffset: 10.0)
        resetButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom)
    }
    
    func setupLayouts() {
        setupTitleLayout()
        setupEditLayout()
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
