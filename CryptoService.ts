"use strict";
class CryptoService {
    constructor() {
        this.encrypt = (value) => {
            const h = new Date().getTime().toString().padStart(16, '0');
            var key = CryptoJS.enc.Utf8.parse(h);
            const encrypted = CryptoJS.AES.encrypt(value, key, {
                keySize: 128 / 8,
                iv: key,
                mode: CryptoJS.mode.CBC,
                padding: CryptoJS.pad.Pkcs7
            });
            return encrypted.toString() + h;
        };
        this.decrypt = (value) => {
            //return crypto.AES.decrypt(value.encrypted, value.h).toString(crypto.enc.Utf8);
        };
    }
}


var service = new CryptoService();
var result = service.encrypt("password");
console.log(result);


// original string : password
// encrypted string : Sw6bOZRnVf8/8BaWyaRn8Q==0001567079972396