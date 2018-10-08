//
//  FemaleRequests.swift
//  VDD_Network_Layers_Example
//
//  Created by Vinh Dang on 3/26/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Alamofire

public enum FemaleRequests: Request {
    case getPerformerList(id: String, pass: String)
    
    public var apiIdentifier: String {
        switch self {
        case .getPerformerList:
            return "API0001 ⬩ Get performer list"
        }
    }
    
    public var path: String {
        switch self {
        case .getPerformerList(_,_):
            return ""
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getPerformerList(_,_):
            return .post
        }
    }
    
    public var parameters: RequestParams {
        switch self {
        case .getPerformerList(let id, let pass):
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
        case .getPerformerList(_,_):
            return .json
        }
    }
}
