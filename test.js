var CryptoJS = require("crypto-js");
// const h = new Date().getTime().toString().padStart(16, '0');
const h = "0001567079972396"
var key = CryptoJS.enc.Utf8.parse(h);
var base64 = CryptoJS.enc.Base64.stringify(key);
console.log('key:', base64);

value = "password";
const encrypted = CryptoJS.AES.encrypt(value, key, {
    keySize: 128 / 8,
    iv: key,
    mode: CryptoJS.mode.CBC,
    padding: CryptoJS.pad.Pkcs7
});

var result = encrypted.toString() + h;
console.log(result);