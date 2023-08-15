//
//  KeyChainData.swift
//  
//
//  Created by jjw-Macbook Pro on 2023/07/11.
//

import Foundation
import KeychainSwift

public struct KeychainData {
    
    public init() {}
    
    public enum KeyChainShared: String {
        case kcIdentifierSecretKey = "key"
    }
    
    /// 키체인 영역에 데이터 저장
    /// - Parameters:
    ///   - value: 값(스트링)
    ///   - key: 키
    public func setKeychain(value: String, key: String, appGroup: String) {
        let keychain = KeychainSwift()
        keychain.accessGroup = appGroup
        keychain.set(value, forKey: key)
    }
    
    public func getKeychain(key: String, appGroup: String) -> String? {
        let keychain = KeychainSwift()
        keychain.accessGroup = appGroup
        return keychain.get(key)
    }
}
