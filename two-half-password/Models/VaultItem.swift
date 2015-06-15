//
//  VaultItem.swift
//  two-half-password
//
//  Created by Xinhong LIU on 15/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa

class VaultItem: NSObject {
    var vault: Vault
    
    var identifier: String!
    var type: String!
    var title: String!
    var urlString: String!
    
    enum VaultItemError {
        enum LoadContentError: ErrorType {
            case FailLoadFile
            case InvalidFile
        }
        
        enum DecryptError: ErrorType {
            case VaultLocked
        }
    }
    
    init(vault: Vault, array: NSArray) throws {
        self.vault = vault
        
        identifier = array[0] as! String
        type = array[1] as! String
        title = array[2] as! String
        urlString = array[3] as! String
    }
    
    func dataPath() -> String {
        return "\(vault.mainDirectoryPath())/\(identifier).1password"
    }
    
    // return encrypted dictionary
    func loadContents() throws -> NSDictionary {
        let data = NSData(contentsOfFile: dataPath())
        guard (data != nil) else {
            throw VaultItemError.LoadContentError.FailLoadFile
        }
        
        var dictionary: NSDictionary!
        
        do {
            dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        } catch {
            throw VaultItemError.LoadContentError.InvalidFile
        }
        
        return dictionary
    }
    
    // return decrypted dictionary
    func info() throws -> NSDictionary {
        let mutableDictionary = NSMutableDictionary(dictionary: try loadContents())
        
        // decode base64
        guard (mutableDictionary["encrypted"] != nil) else {
            throw VaultItemError.LoadContentError.InvalidFile
        }
        
        let encryptedData = NSData(base64EncodedString: mutableDictionary["encrypted"] as! String, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        let (salt, cipher) = Crypto.extractSaltAndCipher(encryptedData!)
        
        guard (vault.unlocked()) else {
            throw VaultItemError.DecryptError.VaultLocked
        }
        
        let (aesKey, iv) = Crypto.OpenSSLKey(vault.encryptionKey!, salt: salt)
        
        let decryptedData = Crypto.AES128Decrypt(aesKey, encryptedKey: cipher, iv: iv)
        
        var decryptedDictionary: NSDictionary!
        
        do {
            decryptedDictionary = try NSJSONSerialization.JSONObjectWithData(decryptedData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        } catch {
            throw VaultItemError.LoadContentError.InvalidFile
        }
        
        mutableDictionary.setValue(decryptedDictionary, forKey: "decrypted")
        
        return mutableDictionary
    }
    
}
