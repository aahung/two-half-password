//
//  UnlockKeysTest.swift
//  two-half-password
//
//  Created by Xinhong LIU on 12/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import XCTest


class UnlockKeysTest: XCTestCase {
    
    let defaultDirectory = "/Users/Hung/Dropbox/Apps/1Password/1Password.agilekeychain/data/default"
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testUnlockKey() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let encryptionKeysFile = "\(defaultDirectory)/encryptionKeys.js"
        print("trying to open encryption keys file: \(encryptionKeysFile)")
        let encryptionKeysData = NSData(contentsOfFile: encryptionKeysFile)
        
        XCTAssert(encryptionKeysData != nil)
        
        var encryptionKeysDictionary: NSDictionary!
        
        do {
            try encryptionKeysDictionary = NSJSONSerialization.JSONObjectWithData(encryptionKeysData!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        } catch {
            print("parsing json failed")
            return
        }
        
        var encryptionKeys: EncryptionKeys?
        
        do {
            encryptionKeys = try EncryptionKeys(dictionary: encryptionKeysDictionary)
        }
        catch {
            print("error! \(error)")
            XCTAssert(encryptionKeys != nil)
        }
        
        XCTAssert(encryptionKeys?.list.count > 0)
        
        for entry: EncryptionKey in encryptionKeys!.list {
            print("data length: \(entry.data.length)")
        }
        
        let SL5Key = encryptionKeys!.SL5EncryptionKey()
        
        let password = "hidden"
        
        if password != "hidden" {
        
            // if not throw any error, then validation success, test pass
            do {
                let _ = try SL5Key.getDecryptedEncryptionKey(password)
            } catch {
                XCTAssert(1 == 0)
            }
            
        }
        
    }
    
    func testEmptyDictionaryParsing() {
        var encryptionKeys: EncryptionKeys?
        
        let dictionary = [:]
        
        do {
            encryptionKeys = try EncryptionKeys(dictionary: dictionary)
        }
        catch {
            XCTAssert(encryptionKeys == nil)
        }
    }
    
    func testKeyDerivation() {
        // data from http://anandam.name/pbkdf2/
        let password = "abcdefg"
        let salt = "yyyyyyyy"
        let iteration = 1000
        let expectationBytes: [UInt8] = [0x38, 0xcf, 0xcd, 0x8e, 0xf1, 0xae, 0xb6, 0x58, 0x57, 0x30, 0x25, 0x6a, 0xeb, 0x86, 0x61, 0xc7, 0x07, 0x6f, 0x1f, 0x54, 0x8a, 0xe6, 0x88, 0xc6, 0xe2, 0x05, 0xa5, 0x00, 0x86, 0x0d, 0xec, 0x45]
        let expectation = NSData(bytes: expectationBytes, length: expectationBytes.count)
        
        
        let reality = Crypto.KeyDerivationPBKDF2SH1(password, salt: salt.dataUsingEncoding(NSUTF8StringEncoding)!, iteration: iteration)
        print("Expect: \(expectation)Actual: \(reality)")
        XCTAssert(reality == expectation)
    }
    
    func testAES128CBCDecryption() {
        let key = "0123456789abcdef".dataUsingEncoding(NSUTF8StringEncoding)!
        let iv = "aaaaaaaaaaaaaaaa".dataUsingEncoding(NSUTF8StringEncoding)!
        
        let encrypted: [UInt8]  = [185, 220, 43, 27, 97, 249, 17, 190, 244, 10, 1, 63, 11, 243, 13, 234, 52, 27, 139, 101, 85, 1, 4, 14, 86, 217, 91, 0, 142, 45, 226, 67, 117, 74, 149, 76, 225, 155, 114, 236, 140, 114, 214, 244, 251, 79, 139, 29, 217, 212, 255, 57, 186, 242, 76, 248, 133, 42, 108, 245, 28, 4, 232, 151, 117, 201, 140, 178, 172, 30, 94, 56, 122, 86, 27, 24, 23, 114, 209, 145, 75, 199, 204, 167, 69, 152, 0, 86, 236, 192, 46, 119, 232, 89, 10, 95, 96, 80, 137, 5, 80, 3, 248, 218, 206, 184, 79, 85, 179, 121, 193, 20, 254, 150, 19, 205, 0, 167, 29, 81, 166, 249, 243, 185, 170, 142, 22, 186, 94, 149, 59, 15, 82, 167, 251, 65, 254, 99, 44, 191, 16, 10, 9, 233, 245, 9, 99, 8, 159, 243, 106, 244, 239, 112, 133, 150, 195, 181, 105, 153, 176, 175, 41, 29, 87, 17, 159, 152, 111, 95, 67, 20, 224, 126, 57, 5, 165, 246, 167, 219, 228, 157, 126, 110, 110, 183, 168, 9, 20, 93, 236, 112, 121, 157, 186, 247, 27, 146, 225, 63, 88, 177, 184, 78, 137, 138, 99, 43, 21, 216, 181, 14, 206, 89, 165, 10, 199, 50, 46, 190, 100, 54, 163, 210, 158, 215, 4, 236, 129, 69, 14, 33, 214, 85, 97, 248, 199, 168, 129, 0, 95, 110, 81, 85, 167, 190, 198, 109, 77, 242, 247, 244, 58, 227, 17, 71, 202, 12, 186, 208, 24, 98, 124, 46, 92, 224, 96, 215, 144, 26, 161, 152, 170, 145, 42, 135, 89, 144, 79, 216, 191, 14, 196, 25, 243, 101, 129, 219, 216, 173, 116, 210, 10, 62, 24, 224, 31, 149, 183, 175, 227, 67, 186, 225, 64, 50, 151, 217, 83, 44, 58, 28, 93, 2, 81, 242, 146, 94, 181, 205, 176, 33, 104, 203, 206, 187, 24, 197, 223, 138, 46, 45, 166, 215, 192, 37, 54, 209, 47, 88, 16, 186, 81, 57, 71, 48, 60, 231, 51, 226, 25, 248, 7, 184, 50, 127, 234, 163, 39, 231, 251, 237, 203, 13, 165, 127, 29, 75, 216, 225, 23, 205, 73, 213, 180, 27, 211, 24, 66, 89, 178, 239, 107, 169, 19, 151, 142, 253, 194, 100, 126, 179, 127, 223, 254, 81, 48, 156, 81, 138, 176, 181, 122, 136, 45, 177, 67, 175, 183, 209, 201, 125, 91, 170, 182, 74, 10, 147, 226, 251, 92, 119, 224, 213, 36, 7, 9, 9, 163, 139, 104, 124, 69, 176, 39, 2, 149, 64, 15, 115, 101, 56, 137, 92, 82, 168, 248, 107, 247, 153, 95, 87, 64, 142, 218, 194, 7, 44, 18, 97, 240, 107, 23, 253, 84, 0, 75, 26, 61, 129, 114, 72, 51, 221, 243, 252, 146, 150, 204, 158, 26, 174, 39, 212, 87, 167, 76, 32, 67, 51, 134, 83, 187, 249, 103, 224, 90, 148, 185, 92, 123, 208, 19, 10, 189, 240, 53, 166, 112, 15, 190, 255, 21, 215, 114, 226, 87, 240, 25, 221, 176, 42, 110, 204, 179, 81, 245, 198, 181, 145, 193, 167, 103, 96, 48, 51, 181, 33, 140, 103, 174, 171, 106, 71, 124, 117, 31, 16, 181, 8, 194, 199, 247, 13, 234, 118, 61, 94, 221, 125, 36, 96, 217, 109, 244, 31, 214, 20, 77, 238, 168, 7, 245, 90, 182, 162, 234, 108, 15, 82, 206, 136, 207, 230, 151, 158, 141, 155, 140, 90, 76, 158, 147, 125, 32, 207, 222, 199, 29, 133, 205, 163, 178, 80, 92, 140, 43, 236, 3, 103, 67, 133, 46, 42, 210, 217, 238, 213, 245, 150, 3, 214, 22, 138, 91, 92, 225, 1, 124, 251, 114, 229, 93, 140, 25, 38, 61, 167, 164, 211, 30, 63, 198, 102, 33, 224, 128, 78, 182, 11, 141, 148, 230, 223, 242, 30, 158, 69, 49, 101, 130, 39, 184, 183, 87, 145, 133, 216, 243, 198, 36, 228, 166, 153, 221, 55, 185, 64, 236, 100, 164, 30, 116, 214, 243, 104, 127, 238, 81, 248, 62, 78, 38, 153, 144, 230, 82, 1, 146, 51, 229, 118, 226, 31, 17, 31, 134, 30, 238, 99, 161, 87, 238, 210, 185, 155, 105, 26, 209, 123, 31, 111, 49, 116, 92, 108, 153, 237, 208, 132, 132, 214, 199, 54, 123, 209, 142, 79, 226, 0, 190, 67, 193, 98, 61, 40, 195, 230, 4, 54, 77, 66, 228, 66, 127, 130, 165, 94, 205, 250, 243, 166, 88, 5, 151, 225, 104, 126, 104, 13, 227, 149, 125, 237, 168, 62, 14, 114, 61, 84, 226, 100, 79, 231, 80, 183, 82, 182, 71, 182, 196, 82, 24, 248, 243, 195, 173, 230, 18, 9, 193, 163, 156, 81, 113, 143, 130, 187, 98, 173, 184, 222, 191, 203, 72, 134, 178, 124, 8, 198, 203, 122, 227, 104, 197, 70, 158, 21, 164, 213, 74, 22, 71, 82, 125, 106, 72, 178, 152, 98, 223, 95, 90, 104, 130, 182, 37, 208, 232, 158, 127, 54, 37, 11, 237, 203, 221, 193, 247, 82, 85, 159, 238, 11, 191, 179, 117, 175, 183, 179, 188, 49, 125, 22, 126, 195, 140, 143, 191, 33, 230, 8, 127, 96, 66, 69, 109, 212, 120, 212, 68, 37, 199, 217, 81, 177, 141, 225, 149, 80, 30, 148, 245, 218, 116, 194, 18, 98, 96, 73, 180, 201, 103, 7, 166, 234, 127, 112, 60, 71, 105, 188, 131, 98, 165, 206, 208, 152, 33, 60, 84, 135, 69, 225, 236, 165, 55, 151, 221, 57, 130, 115, 68, 2, 53, 112, 110, 168, 74, 158, 136, 169, 169, 9, 88, 206, 249, 36, 43, 10, 13, 150, 187, 105, 86, 108, 57, 134, 202, 159, 110, 153, 104, 128, 81, 229, 160, 120, 235, 59, 65, 62, 131, 5, 24, 251, 17, 148, 29, 142, 228, 62, 139, 196, 96, 204, 251, 36, 67, 129, 44, 248, 139, 137, 161, 190, 15, 108, 156, 86, 130, 173, 241, 185, 68, 219, 195, 235, 36, 108, 62, 132, 197, 229, 67, 208, 170, 23, 2, 246, 31, 98, 26, 145, 240, 245, 53, 184, 125, 184]
        
        let decrypted = Crypto.AES128Decrypt(key, encryptedKey: NSData(bytes: encrypted, length: encrypted.count), iv: iv)
        
        let expected = "jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj".dataUsingEncoding(NSUTF8StringEncoding)!
        
        XCTAssert(decrypted == expected)
    }
    
    func testMD5() {
        let string = "helo"
        let expectBytes: [UInt8] = [195, 85, 124, 162, 42, 218, 28, 202, 252, 196, 63, 128, 19, 239, 2, 81]
        let expectData = NSData(bytes: expectBytes, length: expectBytes.count)
        
        XCTAssert(Crypto.MD5(string.dataUsingEncoding(NSUTF8StringEncoding)!) == expectData)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
