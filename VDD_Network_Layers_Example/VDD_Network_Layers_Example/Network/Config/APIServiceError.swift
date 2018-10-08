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

// Store error responded inside api data
class APIError {
    var metalCode: Int?
    var errorCode: String?
    private var errorMessage: String?
    private var exceptionError: Error?
    
    var message: String? {
        if let errorMessage = errorMessage {
            return errorMessage
        }
        if let error = exceptionError {
            switch error {
            case NetworkErrors.badInput:
                #if DEVELOP || STAGING
                    return "(Message in debug/staging mode) Bad input parameters"
                #endif
            case NetworkErrors.badOutput:
                #if DEVELOP || STAGING
                    return "(Message in debug/staging mode) Bad output response data"
                #endif
            case NetworkErrors.noData:
                #if DEVELOP || STAGING
                    return "(Message in debug/staging app) No data found"
                #endif
            default:
                break
            }
        }
        return exceptionError?.localizedDescription
    }
    
    init(metalCode: Int? = nil, errorCode: String? = nil, errorMessage: String? = nil, exceptionError: Error? = nil) {
        self.metalCode = metalCode
        self.errorCode = errorCode
        self.errorMessage = errorMessage
        self.exceptionError = exceptionError
    }
    
    static func tryToParseError(from json: JSON) -> APIError? {
        guard json["success"].intValue == 0 else { return nil }
        let errorCode = json["error"]["error_code"].string
        let errorMessage = json["error"]["error_message"].string
        let error = APIError(errorCode: errorCode, errorMessage: errorMessage)
        return error
    }
}
