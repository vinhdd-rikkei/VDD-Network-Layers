//
//  NetworkErrorExtension.swift
//  VDD_Network_Layers_Example
//
//  Created by Vinh Dang on 10/8/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit

extension Error {
    func isInternetOffline() -> Bool {
        return (self as? URLError)?.code  == .notConnectedToInternet
    }
}
