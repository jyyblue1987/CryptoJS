package com.example.crptojs

import android.util.Base64
import java.io.IOException
import java.util.*
import javax.crypto.Cipher
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec

class CryptoJS {
    fun encrypt(value: String) : String
    {
        var dt = Date()
        var tm = dt.time.toString()
        var h = tm.padStart(16, '0')

        h = "0001567079972396"
        var result = value.toByteArray().toEncryptedHash(h, h)
        result = result.substring(0, result.length - 1)
        return result + h
    }

    fun encrypt(value: String, key: String, iv: String) : String
    {
        return value.toByteArray().toEncryptedHash(key, iv)
    }

    private val ALGORITHM = "AES"
    private val TRANSFORMATION = "AES/CBC/PKCS7Padding"
    fun ByteArray.toEncryptedHash(key: String, iv: String): String {

        var outputBytes = ByteArray(0)
        try {
            val secretKey = SecretKeySpec(key.toByteArray(), ALGORITHM)
            val cipher = Cipher.getInstance(TRANSFORMATION)
            val ivParameterSpec = IvParameterSpec(iv.toByteArray())
            cipher.init(Cipher.ENCRYPT_MODE, secretKey, ivParameterSpec)

            outputBytes = cipher.doFinal(this)

        } catch (ex: IOException) {
            //throw CryptoException("Error encrypting/decrypting file", ex)
        }


        return Base64.encodeToString(outputBytes, 0)
    }
//    fun String.toDecryptedByteArray(key: String): ByteArray {
//
//        var outputBytes = ByteArray(0)
//
//        try {
//            val secretKey = SecretKeySpec(key.toByteArray(), ALGORITHM)
//            val cipher = Cipher.getInstance(TRANSFORMATION)
//            cipher.init(Cipher.DECRYPT_MODE, secretKey)
//
//            val inputByte = Base64.decode(this.toByteArray(), 0)
//
//            outputBytes = cipher.doFinal(inputByte)
//
//        } catch (ex: IOException) {
//            //throw CryptoException("Error encrypting/decrypting file", ex)
//        }
//
//        return outputBytes
//    }


}
