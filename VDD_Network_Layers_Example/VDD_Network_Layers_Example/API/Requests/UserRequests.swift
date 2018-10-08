//
//  UserRequests.swift
//  TestNetworkLayers
//
//  Created by vinhdd on 3/21/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Alamofire

public enum UserRequests: Request {
    case getMemberInfo(id: String, pass: String)
    
    public var apiIdentifier: String {
        switch self {
        case .getMemberInfo:
            return "API0002 ⬩ Get member info"
        }
    }
    
    public var path: String {
        switch self {
        case .getMemberInfo(_,_):
            return ""
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getMemberInfo(_,_):
            return .post
        }
    }
    
    public var parameters: RequestParams {
        switch self {
        case .getMemberInfo(let id, let pass):
            return .body([
                "id": id,
                "pass": pass
            ])
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
    
    public var dataType: DataType {
        switch self {
        case .getMemberInfo(_,_):
            return .json
        }
    }
}
