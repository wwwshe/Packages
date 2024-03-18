//
//  URL+Extension.swift
//
//  Created by jjw-MAC-PC on 2021/08/23.
//

import Foundation

public extension URL {
    var parameters: [String: String] {
        var parameters = [String: String]()
        if let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false),
           let queryItems = urlComponents.queryItems
        {
            for queryItem in queryItems where queryItem.value != nil {
                parameters[queryItem.name] = queryItem.value
            }
        }
        return parameters
    }
}
