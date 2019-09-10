//
//  ViewController.swift
//  CryptoJS
//
//  Created by Admin on 9/11/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        test()
    }
    
    func test() {
        let message     = "password"
        
        let result = CryptoJS.encrypt(value: message)
        
        print(result)
        
        /*
        let keyData = h.data(using:String.Encoding.utf8)!
        let result1 =  keyData.base64EncodedString()
        print(result1);
        
        let encryptedData = CryptoJS.encrypt(data:messageData,   keyData:keyData, ivData:keyData, operation:CryptoJS.jsEncrypt)
        
        let result =  encryptedData.base64EncodedString()
        print(result);
        
        let decryptedData = CryptoJS.encrypt(data:encryptedData, keyData:keyData, ivData:keyData, operation:CryptoJS.jsDecrypt)
        var decrypted     = String(bytes:decryptedData, encoding:String.Encoding.utf8)!
        
        print(decrypted)
         */
    }


}

