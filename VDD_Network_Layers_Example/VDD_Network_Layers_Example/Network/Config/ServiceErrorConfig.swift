//
//  APIErrorConfig.swift
//  VDD_Network_Layers_Example
//
//  Created by vinhdd on 3/27/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

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
