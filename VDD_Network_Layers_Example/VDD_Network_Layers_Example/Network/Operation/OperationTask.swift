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
    func execute(with dispatcher: DispatcherProtocol? = nil,
                 retry: Int? = 5,
                 responseQueue: DispatchQueue? = .main,
                 success: ((_ result: Output) -> Void)? = nil,
                 apiError: ((_ error: APIResponseError) -> Void)? = nil,
                 requestError: ((_ error: Error) -> Void)? = nil) {
        let finalDispatcher = dispatcher ?? NetworkDispatcher.shared
        func handleResponse(body: @escaping () -> Void) {
            (responseQueue ?? .main).async {
                body()
            }
        }
        if let request = self.request {
            do {
                try finalDispatcher.execute(request: request, retry: retry).then({ response in
                    let data = self.parse(response: response)
                    handleResponse {
                        if let result = data.output {
                            success?(result)
                        } else if let error = data.error {
                            apiError?(error)
                        }
                    }
                }).catch { error in
                    handleResponse { requestError?(error) }
                }
            } catch {
                handleResponse { requestError?(error) }
            }
        } else {
            handleResponse { requestError?(NetworkErrors.badInput) }
        }
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
