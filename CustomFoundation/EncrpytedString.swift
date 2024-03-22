//
//  EncrpytedString.swift
//
//
//  Created by JJW on 2024/03/22.
//

import Foundation
import CryptoSwift

public class EncryptedString: Comparable, CustomStringConvertible {
    public var description: String {
        guard let encrypt = encrypt else { return "nil" }
        return String(data: Data(encrypt), encoding: .utf8) ?? "nil"
    }
    
    private var encrypt: [UInt8]?
    private let key: RSA?
    
    public var isEmpty: Bool {
        return false
    }
    
    private init() {
        let rsa = try? RSA(keySize: 2048)
        self.key = rsa
        DeallocHooker.install(to: self) { [weak self] in
            guard let self = self, let count = encrypt?.count  else { return }
            memset(&encrypt!, 0, count)
        }
    }
    
    /// A UTF-8 encoding of `self`.
    public var utf8: String.UTF8View? {
        decrypt()?.utf8
    }
    
    public var last: Character? {
        decrypt()?.last
    }
    
    public convenience init(_ text: String) {
        self.init()
        encrypt(text)
    }
    
    public convenience init(cString nullTerminatedUTF8: UnsafePointer<CChar>) {
        self.init()
        let text = String(cString: nullTerminatedUTF8)
        encrypt(text)
    }

    public convenience init(cString nullTerminatedUTF8: [CChar]) {
        self.init()
        let text = String(cString: nullTerminatedUTF8)
        encrypt(text)
    }
    
    public convenience init(cString nullTerminatedUTF8: UnsafePointer<UInt8>) {
        self.init()
        let text = String(cString: nullTerminatedUTF8)
        encrypt(text)
    }

    public convenience init(cString nullTerminatedUTF8: [UInt8]) {
        self.init()
        let text = String(cString: nullTerminatedUTF8)
        encrypt(text)
    }
    
    public convenience init?(validatingUTF8 cString: UnsafePointer<CChar>) {
        self.init()
        guard let text = String(validatingUTF8: cString) else { return }
        encrypt(text)
    }
    
    public convenience init?(validatingUTF8 cString: [CChar]) {
        self.init()
        guard let text = String(validatingUTF8: cString) else { return }
        encrypt(text)
    }
    
    public convenience init(repeating repeatedValue: String, count: Int) {
        self.init()
        let text = String(repeating: repeatedValue, count: count)
        encrypt(text)
    }
    
    public convenience init(_ scalar: Unicode.Scalar) {
        self.init()
        let text = String(scalar)
        encrypt(text)
    }
    
    public convenience init(_ c: Character) {
        self.init()
        let text = String(c)
        encrypt(text)
    }
    
    public convenience init(_ substring: Substring) {
        self.init()
        let text = String(substring)
        encrypt(text)
    }
    
    @available(swift, introduced: 4.0, message: "Please use failable String.init?(_:UTF8View) when in Swift 3.2 mode")
    public convenience init(_ utf8: String.UTF8View) {
        self.init()
        let text = String(utf8)
        encrypt(text)
    }
    
    
    public convenience init<T>(_ value: T, radix: Int = 10, uppercase: Bool = false) where T : BinaryInteger {
        self.init()
        let text = String(value, radix: radix, uppercase: uppercase)
        encrypt(text)
    }
    
    @available(swift 4)
    public subscript(r: Range<String.Index>) -> Substring? {
        guard let decrypt = decrypt() else { return nil }
        return decrypt[r]
    }
    
    
    public static func + (lhs: EncryptedString, rhs: EncryptedString) -> EncryptedString {
        guard let lhsDecrypt = lhs.decrypt(), let rhsDecrypt = rhs.decrypt() else { return EncryptedString() }
        let text = lhsDecrypt + rhsDecrypt
        return EncryptedString(text)
    }

    public static func += (lhs: inout EncryptedString, rhs: EncryptedString) {
        guard let lhsDecrypt = lhs.decrypt(), let rhsDecrypt = rhs.decrypt() else { return }
        let text = lhsDecrypt + rhsDecrypt
        lhs.encrypt(text)
    }
    
    public static func ~= (lhs: EncryptedString, rhs: EncryptedString) -> Bool {
        guard let lhsDecrypt = lhs.decrypt(), let rhsDecrypt = rhs.decrypt() else { return false }
        return lhsDecrypt ~= rhsDecrypt
    }
    
    public static func < (lhs: EncryptedString, rhs: EncryptedString) -> Bool {
        guard let lhsDecrypt = lhs.decrypt(), let rhsDecrypt = rhs.decrypt() else { return false }
        return lhsDecrypt < rhsDecrypt
    }
    
    public static func == (lhs: EncryptedString, rhs: EncryptedString) -> Bool {
        guard let lhsDecrypt = lhs.decrypt(), let rhsDecrypt = rhs.decrypt() else { return false }
        return lhsDecrypt == rhsDecrypt
    }
}

extension EncryptedString {
    
    public func lowercased() -> EncryptedString {
        guard let decrypt = decrypt() else { return self }
        let lower = decrypt.lowercased()
        return EncryptedString(lower)
    }
    
    public func uppercased() -> EncryptedString {
        guard let decrypt = decrypt() else { return self }
        let upper = decrypt.uppercased()
        return EncryptedString(upper)
    }
    
    public func hasPrefix(_ prefix: EncryptedString) -> Bool {
        guard let decrypt = decrypt(),
                let prefix = prefix.decrypt() else { return false }
        return decrypt.hasPrefix(prefix)
    }
    
    public func hasSuffix(_ suffix: EncryptedString) -> Bool {
        guard let decrypt = decrypt(),
                let suffix = suffix.decrypt() else { return false }
        return decrypt.hasSuffix(suffix)
    }
    
    public func dropLast(_ k: Int) -> Substring? {
        guard let decrypt = decrypt() else { return nil }
        let last = decrypt.dropLast(k)
        encrypt(decrypt)
        return last
    }
    
    public func map<T>(_ transform: (Character) throws -> T) rethrows -> [T] {
        guard let decrypt = decrypt() else { return [] }
        let result = try? decrypt.map(transform)
        return result ?? []
    }
    
    public func dropFirst(_ k: Int = 1) -> Substring? {
        guard let decrypt = decrypt() else { return nil }
        let frist = decrypt.dropFirst(k)
        encrypt(decrypt)
        return frist
    }
    
    public func drop(while predicate: (Character) throws -> Bool) rethrows -> Substring? {
        guard let decrypt = decrypt() else { return nil }
        let drop = try? decrypt.drop(while: predicate)
        encrypt(decrypt)
        return drop
    }
    
    public func prefix(_ maxLength: Int) -> EncryptedString? {
        guard let decrypt = decrypt() else { return nil }
        let prefix = decrypt.prefix(maxLength)
        return EncryptedString(prefix)
    }
    
    public func prefix(while predicate: (Character) throws -> Bool) rethrows -> EncryptedString? {
        guard let decrypt = decrypt() else { return nil }
        let prefix = try decrypt.prefix(while: predicate)
        return EncryptedString(prefix)
    }
    
    private func encrypt(_ string: String) {
        guard let publicKeyData = try? key?.publicKeyExternalRepresentation(),
              let encryptPublicKey = try? RSA(rawRepresentation: publicKeyData) else {
            return
        }
        let privateMessage = try? encryptPublicKey.encrypt(string.bytes)
        encrypt = privateMessage
    }
    
    public func decrypt() -> String? {
        guard let encrypt = encrypt,
              let data = try? key?.decrypt(encrypt) else { return nil }
        return String(data: Data(data), encoding: .utf8)
    }
}
