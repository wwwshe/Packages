//
//  NetworkMonitor.swift
//
//
//  Created by jun wook on 3/17/24.
//

import Alamofire
import Extension
import Foundation
import OSLog

public class NetworkMonitor: EventMonitor {
    public init() {}

    public func requestDidFinish(_ request: Request) {
        os_log("-----------NETWORK Reqeust LOG-----------")
        os_log("Reqeust: %@", request.request?.description ?? "Not Found")
        if let body = request.request?.httpBody?.prettyPrintedJSONString {
            os_log("Body: %@", body)
        }
    }

    public func request<Value>(
        _: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>
    ) {
        os_log("-----------NETWORK Response LOG-----------")
        os_log("Response: %@", response.data?.prettyPrintedJSONString ?? "Not Found")
    }

    public func request(
        _: Request,
        didFailTask _: URLSessionTask,
        earlyWithError _: AFError
    ) {
        os_log("URLSessionTask가 Fail 했습니다.")
    }

    public func request(
        _: Request,
        didFailToCreateURLRequestWithError _: AFError
    ) {
        os_log("URLRequest를 만들지 못했습니다.")
    }

    public func requestDidCancel(_: Request) {
        os_log("request가 cancel 되었습니다")
    }
}
