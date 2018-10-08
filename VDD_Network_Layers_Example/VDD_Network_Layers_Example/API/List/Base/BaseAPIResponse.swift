//
//  UserRequests.swift
//  TestNetworkLayers
//
//  Created by vinhdd on 3/21/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaseAPIResponse: ModelResponseProtocol {
    
    var request: Request
    
    required init(json: JSON, request: Request) {
        self.request = request
    }
    
    func printInfo() {
        print("-> [\(request.apiIdentifier)] Requested successfully !!")
    }
}
