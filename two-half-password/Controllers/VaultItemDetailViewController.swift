//
//  VaultItemDetailViewController.swift
//  two-half-password
//
//  Created by Xinhong LIU on 15/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa
import PureLayout

class Weak<T: AnyObject> {
    weak var value : T?
    init (value: T) {
        self.value = value
    }
}

class VaultItemDetailViewController: NSViewController {

    var item: VaultItem?
    
    var subDetailViewControllers = [String: VaultItemDetailSubViewController]()
    
    @IBOutlet weak var containerView: NSView!
    
    func newItem(notification: NSNotification) {
        print(notification)
        
        showItem(nil, type: notification.object as! String)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("newItem:"), name: "newItem", object: nil)
        
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let webform_WebFormViewController = storyboard.instantiateControllerWithIdentifier("webforms_WebFrom_detail") as! Webforms_WebFormViewController
        subDetailViewControllers["webforms.WebForm"] = webform_WebFormViewController
        
        let unsupportedViewController = storyboard.instantiateControllerWithIdentifier("unsupported_detail") as! UnsupportedViewController
        subDetailViewControllers["unsupported"] = unsupportedViewController
    }
    
    func clearViews() {
        for subView in containerView.subviews {
            subView.removeFromSuperview()
        }
    }
    
    func showItem(item: VaultItem!) {
        self.item = item
        
        showItem(item, type: item.type)
    }
    
    func showItem(item: VaultItem?, type: String) {
        
        clearViews()
        
        var theView: NSView!
        
        if subDetailViewControllers[type] == nil {
            theView = subDetailViewControllers["unsupported"]!.view;
            subDetailViewControllers["unsupported"]!.item = item
        } else {
            theView = subDetailViewControllers[type]!.view;
            subDetailViewControllers[type]!.item = item
        }
        
        containerView.animator().addSubview(theView)
    theView.autoPinEdgesToSuperviewEdgesWithInsets(NSEdgeInsetsZero)
    }
    
}
