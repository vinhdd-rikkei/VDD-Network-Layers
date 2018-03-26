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
// <Don't need enum code below any more because of Alamofire HTTP Method has been used>
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

// Model repsonse protocol based on JSON data (View Controller Layers are able to view this protocol as response data)
public protocol ModelResponseProtocol {
    init(json: JSON)
    func printInfo()
}

// Store error responded inside api data
class APIResponseError {
    private var textList: [String]?
    var error: Error?
    
    var text: String? {
        if let list = textList {
            return list.joined(separator: list.count > 1 ? "\n" : "")
        } else if let description = error?.localizedDescription {
            return description
        }
        return nil
    }
    
    init(text: String?, error: Error? = nil) {
        if let text = text {
            textList = [text]
        }
        self.error = error
    }
    
    init(textList: [String]? = nil, error: Error? = nil) {
        self.textList = textList
        self.error = error
    }
    
    static func tryToParseError(from json: JSON) -> APIResponseError? {
        if let errorList = json["errorMessages"].array {
            let textList: [String] = errorList.map({ ($0.stringValue ) })
            let error = APIResponseError(textList: textList)
            return error
        }
        return nil
    }
}
