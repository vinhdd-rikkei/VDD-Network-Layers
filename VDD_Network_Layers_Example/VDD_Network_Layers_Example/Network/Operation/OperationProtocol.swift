//
//  Operation.swift
//  TestNetworkLayers
//
//  Created by vinhdd on 3/21/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Hydra

protocol OperationProtocol {
    // Define Output type that should returns
    associatedtype Output
    
    // Request
    var request: Request? { get }
}
