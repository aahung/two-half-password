//
//  MainViewController.swift
//  two-half-password
//
//  Created by Xinhong LIU on 14/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa
import SwiftyUserDefaults

class MainViewController: NSViewController {
    
    
    @IBOutlet weak var authContainerView: NSView?
    var vault: Vault? {
        didSet {
            guard (vault != nil) else {
                return
            }
            
            Defaults["vaultPath"] = vault!.path
            Defaults["vaultHost"] = vault!.host.rawValue
            // authContainerView?.hidden = true
            // self.performSegueWithIdentifier("vaultEmbed", sender: self)
        
        }
    }
    
    var shouldLoadVaultViewController = false
    
    func initVault() {
        // read if has vault set up
        if !Defaults.hasKey("vaultPath") || Defaults.valueForKey("vaultPath") == nil
              || !Defaults.hasKey("vaultHost") || Defaults.valueForKey("vaultHost") == nil{
            self.performSegueWithIdentifier("vaultSelect", sender:self)
        } else {
            let path = Defaults.valueForKey("vaultPath") as! String
            let host = Defaults.valueForKey("vaultHost") as! Int
            vault = Vault(path: path, host: host)
        }
    }

    override func viewDidAppear() {
        initVault()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func unlockVault(password: String) -> Bool {
        guard (vault != nil) else {
            return false
        }
        
        do {
            try vault?.authenticate(password)
        } catch {
            return false
        }
        
        authContainerView?.hidden = true
        shouldLoadVaultViewController = true
        self.performSegueWithIdentifier("vaultEmbed", sender: self)
        
        return true
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier == "vaultEmbed") {
            return shouldLoadVaultViewController
        }
        return true
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        let id = segue.identifier
        print("segue with identifier \(id) triggered")
        switch id {
        case "vaultSelect"?:
            let vaultSelectionViewController = segue.destinationController as! VaultSelectionViewController
            vaultSelectionViewController.mainViewController = self
        case "authEmbed"?:
            let authViewController = segue.destinationController as! AuthViewController
            authViewController.mainViewController = self
        default:
            let _ = 0
        }
    }
}