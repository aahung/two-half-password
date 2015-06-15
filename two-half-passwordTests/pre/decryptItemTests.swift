//
//  decryptItemTests.swift
//  two-half-password
//
//  Created by Xinhong LIU on 15/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import XCTest

class decryptItemTests: XCTestCase {

    let vaultPath = "/Users/Hung/Dropbox/Apps/1Password/1Password.agilekeychain"
    var vault: Vault!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        do {
            vault = Vault(path: vaultPath, host: Vault.Host.Dropbox)
            try vault.authenticate("hidden")
            try vault.loadContents()
        } catch {
            
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDecryptItem() {
        let item = vault.items[0]
        do {
            try item.info()
        } catch {
            
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
