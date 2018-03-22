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

class LoginAPI: OperationTask<User> {
    var id: String
    var password: String
    
    init(id: String, password: String) {
        self.id = id
        self.password = password
        super.init()
        self.set(request: UserRequests.getMemberInfo(id: self.id, pass: self.password))
    }
}
