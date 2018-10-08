//
//  NetworkEnviroment.swift
//  TestNetworkLayers
//
//  Created by vinhdd on 3/21/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

// Define response data of requests
public enum Response {
    case json(_: JSON)
    case data(_: Data)
    case error(_: Int?, _: Error)
    
    init(_ response: DataResponse<Any>, for request: Request) {
        // Get status code
        let statusCode = response.response?.statusCode
        
        // Check if error exists
        if let error = response.result.error {
            self = .error(statusCode, error)
            return
        }
        
        // Check request data type to parse response daat
        switch request.dataType {
        case .data:
            guard let responseData = response.data else {
                self = .error(statusCode, NetworkErrors.noData)
                return
            }
            self = .data(responseData)
        case .json:
            guard let jsonData = response.result.value else {
                self = .error(statusCode, NetworkErrors.noData)
                return
            }
            let json: JSON = JSON(jsonData)
            self = .json(json)
        }
    }
}

// Model repsonse protocol based on JSON data (View Controller's layers are able to view this protocol as response data)
public protocol ModelResponseProtocol {
    
    // Request of this response
    var request: Request { set get }
    
    // Set json as input variable
    init(json: JSON, request: Request)
    
    // Action
    func printInfo()
}
