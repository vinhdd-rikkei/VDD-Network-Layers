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
    
    // MARK: - Typealias
    typealias Output = T
    typealias DataResponseSuccess = (_ result: Output) -> Void
    typealias DataResponseApiError = (_ error: APIError) -> Void
    typealias DataResponseRequestError = (_ error: Error) -> Void
    
    // MARK: - Constants
    struct ExecuteData {
        var enviroment: NetworkEnviroment = .default
        var responseQueue: DispatchQueue = .main
        var showIndicator: Bool = true
        var autoShowAlertForApiErrors = true
        var autoShowAlertForRequestErrors = true
        var success: DataResponseSuccess? = nil
        var apiError: DataResponseApiError? = nil
        var requestError: DataResponseRequestError? = nil
        
        init() { }
    }
    
    // MARK: - Variables
    private var executeData = ExecuteData()
    
    private var requestErrorFixedMessage: String?
    
    final var code: String {
        return request?.apiIdentifier ?? "--"
    }
    
    var request: Request? {
        return nil
    }
    
    // MARK: - Init
    init() { }
    
    // MARK: - Builder
    @discardableResult
    func set(enviroment: NetworkEnviroment) -> OperationTask<Output> {
        executeData.enviroment = enviroment
        return self
    }
    
    @discardableResult
    func set(responseQueue: DispatchQueue) -> OperationTask<Output> {
        executeData.responseQueue = responseQueue
        return self
    }
    
    @discardableResult
    func set(silentLoad: Bool) -> OperationTask<Output> {
        executeData.showIndicator = !silentLoad
        executeData.autoShowAlertForApiErrors = !silentLoad
        executeData.autoShowAlertForRequestErrors = !silentLoad
        return self
    }
    
    @discardableResult
    func showIndicator(_ show: Bool) -> OperationTask<Output> {
        executeData.showIndicator = show
        return self
    }
    
    @discardableResult
    func autoShowApiErrorAlert(_ show: Bool) -> OperationTask<Output> {
        executeData.autoShowAlertForApiErrors = show
        return self
    }
    
    @discardableResult
    func autoShowRequestErrorAlert(_ show: Bool, fixedMessage: String? = nil) -> OperationTask<Output> {
        executeData.autoShowAlertForRequestErrors = show
        requestErrorFixedMessage = fixedMessage
        return self
    }
    
    // MARK: - Executing functions
    func execute(success: DataResponseSuccess? = nil,
                 apiError: DataResponseApiError? = nil,
                 requestError: DataResponseRequestError? = nil) {
        func run(queue: DispatchQueue?, body: @escaping () -> Void) {
            (queue ?? .main).async {
                body()
            }
        }
        executeData.success = success
        executeData.apiError = apiError
        executeData.requestError = requestError
        //        guard NetworkSupporter.hasInternet() else {
        //            callbackRequestError(error: NetworkErrors.noInternet)
        //            return
        //        }
        let dispatcher = NetworkDispatcher(enviroment: executeData.enviroment)
        let retry = executeData.enviroment.retryTime
        let showIndicator = executeData.showIndicator
        let responseQueue = executeData.responseQueue
        if let request = self.request {
            do {
                if showIndicator {
                    run(queue: responseQueue) { NetworkIndicator.show() }
                }
                try dispatcher.execute(request: request, retry: retry).then({ response in
                    self.parse(response: response, completion: { [weak self] output, error in
                        run(queue: responseQueue) {
                            if showIndicator {
                                NetworkIndicator.hide()
                            }
                            if let output = output {
                                self?.callbackSuccessError(output: output)
                            } else if let error = error {
                                self?.callbackApiError(error: error)
                            } else {
                                self?.callbackRequestError(error: NetworkErrors.badOutput)
                            }
                        }
                    })
                }).catch { error in
                    run(queue: responseQueue) {
                        if showIndicator {
                            NetworkIndicator.hide()
                        }
                        self.callbackRequestError(error: error)
                    }
                }
            } catch {
                run(queue: responseQueue) {
                    if showIndicator {
                        NetworkIndicator.hide()
                    }
                    self.callbackRequestError(error: error)
                }
            }
        } else {
            run(queue: responseQueue) {
                self.callbackRequestError(error: NetworkErrors.badInput)
            }
        }
    }
    
    func cancel(with dispatcher: DispatcherProtocol? = nil) {
        (dispatcher ?? NetworkDispatcher.shared).cancel()
    }
    
    private func parse(response: Response, completion: @escaping ((_ output: T?, _ error: APIError?) -> Void)) {
        var getJson: JSON?
        switch response {
        case .json(let json):
            getJson = json
        case .data(let data):
            do {
                let json = try JSON.init(data: data)
                getJson = json
            } catch {
                completion(nil, APIError(exceptionError: error))
            }
        case .error(_, let error):
            completion(nil, APIError(exceptionError: error))
        }
        
        guard let json = getJson else {
            completion(nil, APIError(exceptionError: NetworkErrors.badOutput))
            return
        }
        
        guard let error = APIError.tryToParseError(from: json) else {
            if let request = self.request {
                completion(T(json: json, request: request), nil)
            } else {
                completion(nil, APIError(exceptionError: NetworkErrors.badOutput))
            }
            return
        }
        completion(nil, error)
    }
    
    private func callbackSuccessError(output: T) {
        output.printInfo()
        executeData.success?(output)
    }
    
    private func callbackApiError(error: APIError) {
        if executeData.autoShowAlertForApiErrors {
            showAlertFor(apiError: error)
        }
        executeData.apiError?(error)
    }
    
    private func callbackRequestError(error: Error) {
        if executeData.autoShowAlertForRequestErrors {
            if error.isInternetOffline() {
                // Show offline alert
            } else {
                showAlertFor(requestError: error)
            }
        }
        executeData.requestError?(error)
    }
    
    // MARK: - Alerts
    private func showAlertFor(apiError: APIError) {
        // Show alert for api error
    }
    
    private func showAlertFor(requestError: Error) {
        // Show alert for request error
    }
}
