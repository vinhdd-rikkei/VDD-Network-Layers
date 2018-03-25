//
//  RequestError.swift
//  VDD_Network_Layers_Example
//
//  Created by Vinh Dang on 3/26/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class RequestError: NSObject {
    var textList: [String]?
    var error: Error?
    
    var text: String? {
        if let list = textList {
            return list.joined(separator: list.count > 1 ? "\n" : "")
        } else if let description = error?.localizedDescription {
            return description
        }
        return nil
    }
    
    override init() { }
    
    init(textList: [String]? = nil, error: Error? = nil) {
        self.textList = textList
        self.error = error
    }
    
    static func tryToParseError(from json: JSON) -> RequestError? {
        if let errorDic = json["errorMessages"].dictionary, let list = errorDic["messages"]?.array {
            let textList: [String] = list.map({ ($0.stringValue ) })
            let requestError = RequestError(textList: textList)
            return requestError
        }
        return nil
    }
}
