//
//  NetworkConfig.swift
//  TestNetworkLayers
//
//  Created by vinhdd on 3/21/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

// Define the type of repsonse data
// - json: It's a json
// - data: It's a plain data
public enum DataType {
    case json
    case data
}

// Define the type of HTTP method that used in requests
// <Don't need enum code below any more because of Alamofire HTTP Method>
//public enum HTTPMethod: String {
//    case post = "POST"
//    case put = "PUT"
//    case get = "GET"
//    case delete = "DELETE"
//    case patch = "PATCH"
//}

// Define the parameters of a request
// - body: part of the body stream
// - url: as url parameters
public enum RequestParams {
    case body(_: Parameters?)
    case url(_: Parameters?)
}

// Define a list of error cases of response data
public enum NetworkErrors: Error {
    case badInput
    case badOutput
    case noData
}

// Request protocol
public protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParams { get }
    var headers: HTTPHeaders? { get }
    var dataType: DataType { get }
}

// Define response data of requests
public enum Response {
    case json(_: JSON)
    case data(_: Data)
    case error(_: Int?, _: Error?)
    
    init(_ response: DataResponse<Any>, for request: Request) {
        guard response.response?.statusCode == 200, response.result.isSuccess else {
            self = .error(response.response?.statusCode, response.result.error)
            return
        }
        switch request.dataType {
        case .data:
            guard let responseData = response.data else {
                self = .error(response.response?.statusCode, NetworkErrors.noData)
                return
            }
            self = .data(responseData)
        case .json:
            guard let jsonData = response.result.value else {
                self = .error(response.response?.statusCode, NetworkErrors.noData)
                return
            }
            let json: JSON = JSON(jsonData)
            self = .json(json)
        }
    }
}
