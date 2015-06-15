//
//  VaultItemOutlineViewController.swift
//  two-half-password
//
//  Created by Xinhong LIU on 15/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa

class VaultOutlineViewController: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {

    var vaultViewController: VaultViewController!
    
    @IBOutlet weak var outlineView: NSOutlineView!
    class Category: NSObject {
        var type: String
        var items: NSMutableArray
        
        init(type: String) {
            self.type = type
            self.items = NSMutableArray()
        }
    }
    var items: NSMutableDictionary = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func addItems(items: [VaultItem]) {
        for item in items {
            if self.items[item.type] == nil {
                let category = Category(type: item.type)
                self.items.setValue(category, forKey: item.type)
            }
            let category = self.items[item.type] as! Category
            category.items.addObject(item)
        }
        
        outlineView.reloadData()
        outlineView.expandItem(nil, expandChildren: true)
    }
    
    // MARK: NSOutlineView DataSource
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        if (item == nil) {
            return items.count
        } else {
            if (item is Category) {
                return (item as! Category).items.count
            } else {
                return 0
            }
        }
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        return item is Category && (item as! Category).items.count > 0
    }
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        if (item == nil) {
            return items.allValues[index]
        } else {
            if (item is Category) {
                return (item as! Category).items[index]
            } else {
                return 0 // wont be here
            }
        }
    }
    
    func outlineView(outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) -> AnyObject? {
        if (item == nil) {
            return ""
        } else {
            if (item is Category) {
                return (item as! Category).type
            } else {
                return (item as! VaultItem).title
            }
        }
    }
    
    func outlineViewSelectionDidChange(notification: NSNotification) {
        let row = outlineView.selectedRow
        guard (row >= 0) else {
            return
        }
        
        let item = outlineView.itemAtRow(row)
        
        if item != nil && !(item is Category) {
            vaultViewController.didSelectVaultItem(item as! VaultItem)
        }
    }
}
