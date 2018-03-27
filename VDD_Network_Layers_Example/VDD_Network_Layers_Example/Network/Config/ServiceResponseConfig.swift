//
//  ResponseConfig.swift
//  VDD_Network_Layers_Example
//
//  Created by vinhdd on 3/27/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

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
