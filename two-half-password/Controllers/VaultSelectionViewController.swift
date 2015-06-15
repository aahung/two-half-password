//
//  VaultSelectionViewController.swift
//  two-half-password
//
//  Created by Xinhong LIU on 14/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa

enum VaultSelectionError: ErrorType {
    case MissingDropbox1PasswordDirectory
    case MissingKeychainFileInDirectory
}

class VaultSelectionViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    weak var mainViewController: MainViewController?
    var vaults: [Vault] = []
    var selectedVault: Vault? {
        didSet {
            if (selectedVault != nil) {
                selectButton.enabled = true
            } else {
                selectButton.enabled = false
            }
        }
    }
    
    @IBOutlet weak var selectButton: NSButton!
    @IBOutlet weak var tableView: NSTableView?
    
    @IBAction func select(sender: AnyObject) {
        mainViewController!.vault = selectedVault
        self.dismissController(self)
    }
    
    // auto search in ~/Dropbox/Apps/1password and return keychain path if found
    func searchInDropbox() throws -> String {
        let fileManager = NSFileManager.defaultManager()
        let homeDirectory = NSHomeDirectory()
        let dropboxPath = "\(homeDirectory)/Dropbox"
        let onepasswordDirectoryPath = "\(dropboxPath)/Apps/1Password"
        var onepasswordDirectoryContents: [String]?
        do {
            onepasswordDirectoryContents = try fileManager.contentsOfDirectoryAtPath(onepasswordDirectoryPath)
        } catch {
            throw VaultSelectionError.MissingDropbox1PasswordDirectory
        }
        for onepasswordDirectoryContent in onepasswordDirectoryContents! {
            if onepasswordDirectoryContent == "1Password.agilekeychain" {
                return "\(onepasswordDirectoryPath)/\(onepasswordDirectoryContent)"
            }
        }
        // not found keychain
        throw VaultSelectionError.MissingKeychainFileInDirectory
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectButton.enabled = false
    }
    
    override func viewDidAppear() {
        do {
            let dropboxKeychainPath = try searchInDropbox()
            let dropboxKeychain = Vault(path: dropboxKeychainPath, host: Vault.Host.Dropbox)
            vaults.append(dropboxKeychain)
        } catch {
            print(error)
        }
        
        tableView?.reloadData()
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return vaults.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let view = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        
        if tableColumn!.identifier == "keychainTableColumn" {
            view.imageView!.image = NSImage(named: "Dropbox-100")
            view.textField!.stringValue = vaults[row].path
        }
        return view
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 60
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let row = tableView!.selectedRow
        guard (row >= 0) else {
            selectedVault = nil
            return
        }
        selectedVault = vaults[row]
    }
    
}
