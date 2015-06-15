//
//  Crypto.swift
//  two-half-password
//
//  Created by Xinhong LIU on 13/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Foundation

class Crypto {
    class func AES128Decrypt(aesKey: NSData, encryptedKey: NSData, iv: NSData) -> NSData {
        let decryptedSize = kCCBlockSizeAES128 + encryptedKey.length
        let decryptedData = NSMutableData(length: decryptedSize)!
        let decryptedCountData = NSMutableData(length: sizeof(Int))!
        
        CCCrypt(CCOperation(kCCDecrypt), CCAlgorithm(kCCAlgorithmAES128), CCOperation(kCCOptionPKCS7Padding), UnsafePointer<Void>(aesKey.bytes), aesKey.length, UnsafePointer<Void>(iv.bytes), UnsafePointer<Void>(encryptedKey.bytes), encryptedKey.length, UnsafeMutablePointer<Void>(decryptedData.mutableBytes), decryptedSize, UnsafeMutablePointer<Int>(decryptedCountData.bytes))
        
        var decryptedCount: NSInteger = 0
        decryptedCountData.getBytes(&decryptedCount, length: sizeof(NSInteger))
        print("encrypted length: \(encryptedKey.length) decrypted length: \(decryptedCount)")
    
        let decrypted = NSData(bytes: decryptedData.mutableBytes, length: decryptedCount)
        
        return decrypted
    }
    
    class func KeyDerivationPBKDF2SH1(password: String, salt: NSData, iteration: Int) -> NSData {
        let passwordLength = password.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        let derivedKey = NSMutableData(length: 32)!
        
        let _ = CCKeyDerivationPBKDF(CCPBKDFAlgorithm(kCCPBKDF2), NSString(string: password).UTF8String, passwordLength, UnsafePointer<UInt8>(salt.bytes), salt.length, CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA1), uint(iteration), UnsafeMutablePointer<UInt8>(derivedKey.mutableBytes), derivedKey.length)
        
        return NSData(bytes: derivedKey.mutableBytes, length: 32)
    }
    
    class func MD5(data: NSData) -> NSData {
        let hash = NSMutableData(length: 16)!
        CC_MD5(UnsafePointer<Void>(data.bytes), CC_LONG(data.length), UnsafeMutablePointer<UInt8>(hash.mutableBytes))
        
        return NSData(bytes: hash.mutableBytes, length: 16)
    }
    
    class func OpenSSLKey(key: NSData, salt: NSData) -> (aesKey: NSData, iv: NSData) {
        let mutData = NSMutableData(data: key)
        mutData.appendData(salt)
        
        let aesKey = Crypto.MD5(mutData)
        
        
        
        let mutData2 = NSMutableData(data: aesKey)
        mutData2.appendData(key)
        mutData2.appendData(salt)
        
        let iv = Crypto.MD5(mutData2)
        
        return (aesKey, iv)
    }
    
    class func extractSaltAndCipher(data: NSData) -> (salt: NSData, cipher: NSData) {
        return (data.subdataWithRange(NSMakeRange(8, 8)),
            data.subdataWithRange(NSMakeRange(16, data.length - 16)))
    }
}