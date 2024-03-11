//
//  API.swift
//
//  Created by jun wook on 2023/03/03.
//  Updated by jjw 2023/07/15.
//  Copyright © 2023 jjw. All rights reserved.
//

import Foundation

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    
    var string: String {
        return self.rawValue
    }
}

public enum API {
    case detail
    
    var baseUrl: String {
        return ""
    }
    
    var path: String {
        switch self {
        case .detail:
            return ""
        }
    }
    
    var url: URL? {
        return URL(string: baseUrl + path)
    }
    
    var method: HttpMethod {
        switch self {
        case .detail:
            return .get
        }
    }
    
    var sampleJson: String {
        switch self {
        case .detail:
            return "cached_data"
        }
    }
}
