//
//  CryptoJS.swift
//  CryptoJS
//
//  Created by Admin on 9/11/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import CommonCrypto

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

extension String {
    @discardableResult
    mutating func padStart(_ length: Int, with string: String = " ") -> String {
        self = paddingStart(length, with: string)
        return self
    }
    
    func paddingStart(_ length: Int, with string: String = " ") -> String {
        guard count < length else { return self }
        
        let padLength = length - count
        if padLength < string.count {
            return string[string.startIndex..<string.index(string.startIndex, offsetBy: padLength)] + self
        } else {
            var padding = string
            while padding.count < padLength {
                padding.append(string)
            }
            return padding[padding.startIndex..<padding.index(padding.startIndex, offsetBy: padLength)] + self
        }
    }
}

class CryptoJS: NSObject {
    
    public static let jsEncrypt = 1
    public static let jsDecrypt = 2
    
    static func encrypt(data:Data, keyData:Data, ivData:Data, operation:Int) -> Data {
        let cryptLength  = size_t(data.count + kCCBlockSizeAES128)
        var cryptData = Data(count:cryptLength)
        
        let keyLength = size_t(kCCKeySizeAES128)
        //let options   = CCOptions(kCCOptionPKCS7Padding | kCCModeCBC)
        let options   = CCOptions(kCCOptionPKCS7Padding)

        var numBytesEncrypted :size_t = 0
        var mode = kCCEncrypt
        
        if operation == jsEncrypt {
            mode = kCCEncrypt
        } else {
            mode = kCCDecrypt
        }
        
        let cryptStatus = cryptData.withUnsafeMutableBytes {cryptBytes in
            data.withUnsafeBytes {dataBytes in
                ivData.withUnsafeBytes {ivBytes in
                    keyData.withUnsafeBytes {keyBytes in
                        CCCrypt(CCOperation(mode),
                                CCAlgorithm(kCCAlgorithmAES),
                                options,
                                keyBytes, keyLength,
                                ivBytes,
                                dataBytes, data.count,
                                cryptBytes, cryptLength,
                                &numBytesEncrypted)
                    }
                }
            }
        }
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.removeSubrange(numBytesEncrypted..<cryptData.count)
            
        } else {
            print("Error: \(cryptStatus)")
        }
        
        return cryptData;
    }
    
    static func encrypt(value:String) -> String {
        let messageData = value.data(using:String.Encoding.utf8)!
        
        let dt = Date().millisecondsSince1970
        var strTime = String(dt)
        //let h = strTime.padStart(16, with:"0")
        let h = "0001567079972396"
        let keyData = h.data(using:String.Encoding.utf8)!
        
        let data = encrypt(data: messageData, keyData: keyData, ivData: keyData, operation: jsEncrypt)
        let result =  data.base64EncodedString() + h
        
        return result
    }
    
    static func decrypt(value:String) {
    }
}
