//
//  EncryptionKeys.swift
//  two-half-password
//
//  Created by Xinhong LIU on 13/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa

enum EncryptionKeyParsingError: ErrorType {
    case MissingData
    
    case DataLengthNotMatch
    
    case MissingValidation
    case MissingLevel
    case MissingIterations
    case MissingIdentifier
}

enum EncryptionKeysParsingError: ErrorType {
    case MissingSL5
    case MissingList
}

enum EncryptionKeyValidationError: ErrorType {
    case InvalidKey
}

class EncryptionKey: NSObject {
    
    // key data
    var data: NSData!
    
    var validation: NSData!
    
    // encryption level
    var level: String!
    
    // identifier
    var identifier: String!
    
    // iteration number
    var iterations: Int!
    
    func getSaltAndCipher() -> (salt: NSData, cipher: NSData) {
        return (data.subdataWithRange(NSMakeRange(8, 8)),
            data.subdataWithRange(NSMakeRange(16, data.length - 16)))
    }
    
    func getValidationSaltAndCipher() -> (salt: NSData, cipher: NSData) {
        return (validation.subdataWithRange(NSMakeRange(8, 8)),
            validation.subdataWithRange(NSMakeRange(16, validation.length - 16)))
    }
    
    // get decryptedEncryptionKey
    func getDecryptedEncryptionKey(password: String) throws -> NSData {
        let (salt, cipher) = getSaltAndCipher()
        let derivedKey = Crypto.KeyDerivationPBKDF2SH1(password, salt: salt, iteration: iterations)
        
        let aesKey = derivedKey.subdataWithRange(NSMakeRange(0, 16))
        let iv = derivedKey.subdataWithRange(NSMakeRange(16, 16))
        
        let decryptedKey = Crypto.AES128Decrypt(aesKey, encryptedKey: cipher, iv: iv)
        
        
        // validate
        let (validationSalt, validationCipher) = getValidationSaltAndCipher()
        
        
        let (validationAesKey, validationIv) = Crypto.OpenSSLKey(decryptedKey, salt: validationSalt)
        
        
        let decryptedValidationKey = Crypto.AES128Decrypt(validationAesKey, encryptedKey: validationCipher, iv: validationIv)
        
        guard decryptedValidationKey == decryptedKey else {
            throw EncryptionKeyValidationError.InvalidKey
        }
        
        return decryptedKey
    }
    
    // init from a json object
    init(dictionary: NSDictionary) throws {
        super.init()
        
        let dataString = dictionary.valueForKey("data") as! String
        
        data = NSData(base64EncodedString: dataString, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        guard data.length == 1056 else {
            throw EncryptionKeyParsingError.DataLengthNotMatch
        }
        
        guard dictionary.valueForKey("level") != nil else {
            throw EncryptionKeyParsingError.MissingLevel
        }
        
        level = dictionary.valueForKey("level") as! String
        
        guard dictionary.valueForKey("validation") != nil else {
            throw EncryptionKeyParsingError.MissingValidation
        }
        
        let validationString = dictionary.valueForKey("validation") as! String
        validation = NSData(base64EncodedString: validationString, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        guard dictionary.valueForKey("identifier") != nil else {
            throw EncryptionKeyParsingError.MissingIdentifier
        }
        
        identifier = dictionary.valueForKey("identifier") as! String
        
        guard dictionary.valueForKey("iterations") != nil else {
            throw EncryptionKeyParsingError.MissingIterations
        }
        
        iterations = dictionary.valueForKey("iterations") as! Int
    }
}

class EncryptionKeys: NSObject{
    
    // identifier of SL3 level key
    var SL3: String?
    
    // identifier of SL5 level key
    var SL5: String!
    
    var list: [EncryptionKey]!
    
    func SL5EncryptionKey() -> EncryptionKey {
        if list.count == 1 || list.first!.level == "SL5" {
            return list.first!
        } else {
            return list.last!
        }
    }
    
    // init with json
    init(dictionary: NSDictionary) throws {
        super.init()
        
        guard dictionary.valueForKey("SL5") != nil else {
            throw EncryptionKeysParsingError.MissingSL5
        }
        
        SL3 = dictionary.valueForKey("SL3") as? String
        
        SL5 = dictionary.valueForKey("SL5") as! String
        
        list = []
        
        guard dictionary.valueForKey("list") != nil else {
            throw EncryptionKeysParsingError.MissingList
        }
        
        let objectList = dictionary.valueForKey("list") as! [NSDictionary]
        
        for d: NSDictionary in objectList {
            let encryptionKey = try EncryptionKey(dictionary: d)
            list.append(encryptionKey)
        }
    }
}
