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
    
    var request: Request! {
        return self.request
    }
    
    init() { }
    
    // MARK: - Executing functions
    func execute(with dispatcher: DispatcherProtocol? = nil, retry: Int? = 1) -> Promise<Output> {
        let finalDispatcher = dispatcher ?? NetworkDispatcher.shared
        return Promise<Output>({ resolve, reject, status in
            do {
                try finalDispatcher.execute(request: self.request, retry: retry).then({ response in
                    let data = self.parse(response: response)
                    if let output = data.output { resolve(output) }
                    if let error = data.error { reject(error) }
                }).catch(reject)
            } catch {
                reject(error)
            }
        })
    }
    
    func cancel(with dispatcher: DispatcherProtocol? = nil) {
        let finalDispatcher = dispatcher ?? NetworkDispatcher.shared
        finalDispatcher.cancel()
    }
    
    private func parse(response: Response) -> (output: T?, error: Error?) {
        switch response {
        case .json(let json):
            return (output: T(json: json), error: nil)
        case .data(let data):
            do {
                let json = try JSON.init(data: data)
                return (output: T(json: json), error: nil)
            } catch {
                return (output: nil, error: error)
            }
        case .error(_, let error):
            if let error = error {
                return (output: nil, error: error)
            }
            return (output: nil, error: nil)
        }
    }
}

