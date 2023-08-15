//
//  UserDefaultData.swift
//  
//
//  Created by jjw-Macbook Pro on 2023/07/11.
//

import Foundation

public struct UserDefaultData {
    private let userDefault = UserDefaults.standard
    
    public init() {}
    
    public func setString(key: String, value: String) {
        userDefault.set(value, forKey: key)
    }
    
    public func getString(key: String) -> String? {
        return userDefault.string(forKey: key)
    }
}
