//
//  OperationTask.swift
//  TestNetworkLayers
//
//  Created by vinhdd on 3/22/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Hydra
import SwiftyJSON

class OperationTask<T: ModelResponseProtocol>: OperationProtocol {
    
    // MARK: - Variables
    typealias Output = T
    typealias RequestDataResponse = (output: Output?, error: APIResponseError?)
    
    var request: Request? {
        return self.request
    }
    
    init() { }
    
    // MARK: - Executing functions
    func execute(with dispatcher: DispatcherProtocol? = nil, retry: Int? = 1) -> Promise<RequestDataResponse> {
        let finalDispatcher = dispatcher ?? NetworkDispatcher.shared
        return Promise<RequestDataResponse>({ resolve, reject, status in
            if let request = self.request {
                do {
                    try finalDispatcher.execute(request: request, retry: retry).then({ response in
                        let data = self.parse(response: response)
                        resolve(RequestDataResponse(data.output, data.error))
                    }).catch { error in
                        reject(error)
                    }
                } catch {
                    reject(error)
                }
            } else {
                reject(NetworkErrors.badInput)
            }
        })
    }
    
    func cancel(with dispatcher: DispatcherProtocol? = nil) {
        let finalDispatcher = dispatcher ?? NetworkDispatcher.shared
        finalDispatcher.cancel()
    }
    
    private func parse(response: Response) -> (output: T?, error: APIResponseError?) {
        var getJson: JSON?
        switch response {
        case .json(let json):
            getJson = json
        case .data(let data):
            do {
                let json = try JSON.init(data: data)
                getJson = json
            } catch {
                return (output: nil, error: APIResponseError(error: error))
            }
        case .error(_, let error):
            if let error = error {
                return (output: nil, error: APIResponseError(error: error))
            }
            return (output: nil, error: nil)
        }
        if let json = getJson {
            if let error = APIResponseError.tryToParseError(from: json) {
                return (output: nil, error: error)
            } else {
                return (output: T(json: json), error: nil)
            }
        } else {
            return (output: nil, error: APIResponseError(error: NetworkErrors.badOutput))
        }
    }
}
