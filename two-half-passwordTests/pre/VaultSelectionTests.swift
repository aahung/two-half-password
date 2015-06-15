//
//  VaultSelectionTests.swift
//  two-half-password
//
//  Created by Xinhong LIU on 14/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import XCTest

class VaultSelectionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSearchingInDropbox() {
        
        let fileManager = NSFileManager.defaultManager()
        let homeDirectory = NSHomeDirectory()
        let dropboxPath = "\(homeDirectory)/Dropbox"
        let onepasswordDirectoryPath = "\(dropboxPath)/Apps/1Password"
        do {
            let onepasswordDirectoryContents = try fileManager.contentsOfDirectoryAtPath(onepasswordDirectoryPath)
            print(onepasswordDirectoryContents)
        } catch {
            print(error)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
