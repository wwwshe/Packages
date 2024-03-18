//
//  String+Encrypt.swift
//
//

import CommonCrypto
import Foundation

public extension String {
    /// MD5로 암호화
    #warning("iOS 13이상에서는 MD5 사용 지양")
    func MD5() -> String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)

        if let d = data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (ptr: UnsafeRawBufferPointer) in
                CC_MD5(ptr.baseAddress, CC_LONG(d.count), &digest)
            }
        }
        return (0 ..< length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }

    /// sha256 해쉬
    var sha256: String? {
        guard let stringData = data(using: String.Encoding.utf8) else { return nil }
        return digest(input: stringData as NSData).base64EncodedString(options: [])
    }

    private func digest(input: NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }

    /// hmac
    func hmac(_ key: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA512), key, key.count, self, count, &digest)

        let data = Data(bytes: digest, count: digest.count)
        return data.map { String(format: "%02hhx", $0) }.joined()
    }
}
