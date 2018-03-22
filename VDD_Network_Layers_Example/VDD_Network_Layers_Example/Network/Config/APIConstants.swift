//
//  APIConstants.swift
//  TestNetworkLayers
//
//  Created by vinhdd on 3/21/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Alamofire

class APIConstants {
    static var baseUrl: String {
        #if DEBUG
            return ""
        #elseif STAGING
            return ""
        #else
            return ""
        #endif
    }
    
    static var httpHeaders: HTTPHeaders {
        #if DEBUG
            return ["Content-Type": "application/x-www-form-urlencoded"]
        #elseif STAGING
            return ["Content-Type": "application/x-www-form-urlencoded"]
        #else
            return ["Content-Type": "application/x-www-form-urlencoded"]
        #endif
    }
}
