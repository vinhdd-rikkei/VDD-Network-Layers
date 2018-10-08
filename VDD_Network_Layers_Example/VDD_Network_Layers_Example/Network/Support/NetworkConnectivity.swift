//
//  APISupporter.swift
//  Hemophilia_iOS
//
//  Created by Vinh Dang on 10/4/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Alamofire

class NetworkConnectivity {
    static func hasInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
