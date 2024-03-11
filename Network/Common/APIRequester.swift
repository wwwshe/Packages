//
//  APIRequester.swift
//  
//
//  Created by jun wook on 2023/07/15.
//

import Foundation
import RxSwift
import RxCocoa
import DataUtility

public struct APIRequester {
    let api: API
    let isSample: Bool
    
    public init(
        api: API,
        _ isSample: Bool = false
    ) {
        self.api = api
        self.isSample = isSample
    }
    
    public func request<T: Codable>(type: T.Type) -> Single<T> {
        
        if isSample {
            let jsonUtil = JsonUtility()
            do {
                let data = try jsonUtil.readJsonToModel(
                    type: T.self,
                    bundle: .module,
                    name: api.sampleJson
                )
                
                return Single.just(data)
            } catch {
                return Single.error(error)
            }
        } else {
            return fetchData(api: api)
        }
    }
    
    private func fetchData<T: Codable>(api: API) -> Single<T> {
        guard let url = api.url else {
            return Single.error(URLError(.badURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = api.method.string
        
        return URLSession.shared.rx
            .data(request: request)
            .map { data in
                do {
                    let res = try JSONDecoder().decode(T.self, from: data)
                    
                    return res
                } catch {
                    throw error
                }
            }
            .catch { error in
                .error(error)
            }
            .asSingle()
    }
}
