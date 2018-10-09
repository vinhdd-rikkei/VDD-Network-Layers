//
//  NetworkConnectivity.swift
//  VDD_Network_Layers_Example
//
//  Created by Vinh Dang on 10/8/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Alamofire

class NetworkConnectivity {
    static func hasInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
