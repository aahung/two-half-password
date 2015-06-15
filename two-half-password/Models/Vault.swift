//
//  Vault.swift
//  two-half-password
//
//  Created by Xinhong LIU on 14/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa

class Vault: NSObject {
    enum Host: Int {
        case Dropbox = 2
        case iCloud = 1
    }
    
    var path: String
    var host: Host
    var encryptionKey: NSData?
    
    init(path: String, host: Vault.Host) {
        self.path = path
        self.host = host
    }
    
    init(path: String, host: Int) {
        self.path = path
        self.host = Host(rawValue: host)!
    }
    
    func mainDirectoryPath() -> String {
        return "\(path)/data/default"
    }
    
    func encryptionKeyPath() -> String {
        return "\(mainDirectoryPath())/encryptionKeys.js"
    }
    
    enum AuthenticationError: ErrorType {
        case FailLoadEncryptionKeyFile
        case InvalidEncryptionKeyFile
    }
    
    func authenticate(password: String) throws {
        let encryptionKeysData = NSData(contentsOfFile: encryptionKeyPath())
        guard (encryptionKeysData != nil) else {
            throw AuthenticationError.FailLoadEncryptionKeyFile
        }
        
        var encryptionKeysDictionary: NSDictionary!
        
        do {
            encryptionKeysDictionary = try NSJSONSerialization.JSONObjectWithData(encryptionKeysData!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        } catch {
            throw AuthenticationError.InvalidEncryptionKeyFile
        }
        
        var encryptionKeys: EncryptionKeys?
        
        do {
            encryptionKeys = try EncryptionKeys(dictionary: encryptionKeysDictionary)
        }
        catch {
            throw AuthenticationError.InvalidEncryptionKeyFile
        }
        
        encryptionKey = try encryptionKeys!.SL5EncryptionKey().getDecryptedEncryptionKey(password)
    }
}
