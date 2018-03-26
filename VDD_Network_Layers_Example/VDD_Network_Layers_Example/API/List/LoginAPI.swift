//
//  LoginTask.swift
//  TestNetworkLayers
//
//  Created by vinhdd on 3/21/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Hydra
import SwiftyJSON

class LoginAPI: OperationTask<LoginResponse> {
    var id: String
    var password: String
    
    override var request: Request! {
        return UserRequests.getMemberInfo(id: self.id, pass: self.password)
    }
    
    init(id: String, password: String) {
        self.id = id
        self.password = password
    }
}

class LoginResponse: ModelResponseProtocol {
    var isSuccess: Bool = false
    var user: User?
    
    required init(json: JSON) {
        // Parse json data to local variables
        isSuccess = json["isSuccess"].boolValue
        user = User.init(json: json["member"])
    }
    
    func printInfo() {
        print("=> [LoginResponse] Is success: \(isSuccess)")
        user?.printInformation()
    }
}
