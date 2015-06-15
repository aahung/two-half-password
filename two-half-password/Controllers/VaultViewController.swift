//
//  VaultViewController.swift
//  two-half-password
//
//  Created by Xinhong LIU on 15/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa

class VaultViewController: NSViewController {

    weak var vaultOutlineViewController: VaultOutlineViewController?
    var vault: Vault!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try vault.loadContents()
        } catch Vault.VaultError.LoadContentError.FailLoadFile {
            let alert = NSAlert()
            alert.messageText = "Failed to open contents.js"
            alert.runModal()
        } catch Vault.VaultError.LoadContentError.InvalidFile {
            let alert = NSAlert()
            alert.messageText = "contents.js is invalid"
            alert.runModal()
        } catch {
            let alert = NSAlert()
            alert.messageText = "Unknown error"
            alert.runModal()
        }
        
        vaultOutlineViewController?.addItems(vault.items)
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        let id = segue.identifier
        print("segue with identifier \(id) triggered")
        switch id {
        case "outlineEmbed"?:
            vaultOutlineViewController = segue.destinationController as? VaultOutlineViewController
        default:
            let _ = 0
        }
    }
    
}
