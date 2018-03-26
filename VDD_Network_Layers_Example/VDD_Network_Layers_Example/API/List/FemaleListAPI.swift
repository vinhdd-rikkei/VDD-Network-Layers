//
//  PerformerListAPI.swift
//  VDD_Network_Layers_Example
//
//  Created by Vinh Dang on 3/26/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Hydra
import SwiftyJSON

class FemaleListAPI: OperationTask<FemaleListResponse> {
    var id: String
    var password: String
    
    override var request: Request! {
        return FemaleRequests.getPerformerList(id: self.id, pass: self.password)
    }
    
    init(id: String, password: String) {
        self.id = id
        self.password = password
    }
}

class FemaleListResponse: ModelResponseProtocol {
    var isSuccess: Bool = false
    var isMemberContentsFullMode: Bool = false
    var onlineFemales: [Female]?
    var offlineFemales: [Female]?
    
    var allFemales: [Female] {
        return (onlineFemales ?? []) + (offlineFemales ?? [])
    }
    
    required init(json: JSON) {
        // Parse json data to local variables
        isSuccess = json["isSuccess"].boolValue
        isMemberContentsFullMode = json["isMemberContentsFullMode"].boolValue
        if let onlineList = json["performers"]["online"].array {
            onlineFemales = [Female]()
            onlineList.forEach {
                onlineFemales?.append(Female(json: $0))
            }
        }
        if let offlineList = json["performers"]["offline"].array {
            offlineFemales = [Female]()
            offlineList.forEach {
                offlineFemales?.append(Female(json: $0))
            }
        }
    }
    
    func printInfo() {
        print("=> [PerformerListResponse] Is success: \(isSuccess)")
        print("=> Online list count: \((onlineFemales ?? []).count)")
        print("=> Offline list count: \((offlineFemales ?? []).count)")
        print("=> Total amount: \(allFemales.count)")
    }
}
