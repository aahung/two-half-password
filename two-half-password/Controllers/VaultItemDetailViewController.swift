//
//  VaultItemDetailViewController.swift
//  two-half-password
//
//  Created by Xinhong LIU on 15/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa

class Weak<T: AnyObject> {
    weak var value : T?
    init (value: T) {
        self.value = value
    }
}

class VaultItemDetailViewController: NSViewController {

    var item: VaultItem?
    
    @IBOutlet weak var titleField: NSTextField!
    
    
    // MARK: Container Views
    @IBOutlet weak var webforms_WebFormsContainerView: NSView!
    @IBOutlet weak var unsupportedContainerView: NSView!
    
    var containerViews: [NSView]!
    var subDetailViewControllers = [String: Weak<VaultItemDetailSubViewController>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        containerViews = [webforms_WebFormsContainerView, unsupportedContainerView]
        
        for containerView in containerViews {
            containerView.hidden = true
        }
    }
    
    func showItem(item: VaultItem?) {
        self.item = item
        
        guard (item != nil) else {
            // hide everything
            titleField.hidden = true
            return
        }
        
        titleField.hidden = false
        titleField.stringValue = item!.title
        
        for containerView in containerViews {
            containerView.hidden = true
        }
        
        switch (item!.type) {
        case "webforms.WebForm":
            webforms_WebFormsContainerView.hidden = false
        default:
            unsupportedContainerView.hidden = false
        }
        
        if subDetailViewControllers[item!.type] == nil {
            subDetailViewControllers["unsupported"]!.value?.loadItem(item!)
        } else {
            subDetailViewControllers[item!.type]!.value?.loadItem(item!)
        }
        
        
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        let id = segue.identifier
        guard (id != nil) else {
            return
        }
        
        let vaultItemDetailSubViewController = segue.destinationController as! VaultItemDetailSubViewController
        if id!.rangeOfString("itemEmbed-") != nil {
            let type = id!.substringFromIndex(advance(id!.startIndex, 10))
            subDetailViewControllers[type] = Weak<VaultItemDetailSubViewController>(value: vaultItemDetailSubViewController)
        }
    }
    
}
