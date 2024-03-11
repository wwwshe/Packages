//
//  JsonUtility.swift
//  
//
//  Created by jun wook on 2023/07/15.
//

import Foundation

/// Json 유틸리티
public struct JsonUtility {
    public init () { }
    public func readJsonToModel<T: Codable>(
        type: T.Type,
        bundle: Bundle,
        name: String
    ) throws -> T {
        if let path = bundle.path(forResource: name, ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url)
                let object = try JSONDecoder().decode(type, from: data)
                return object
            } catch {
                print("Error reading JSON file: \(error.localizedDescription)")
            }
        }
        throw JsonError.notFound
    }
}
