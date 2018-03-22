//
//  NetworkDispatcher.swift
//  TestNetworkLayers
//
//  Created by vinhdd on 3/21/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Hydra
import Alamofire

class NetworkDispatcher: DispatcherProtocol {
    // Singleton variable for using default network enviroment
    static var shared = NetworkDispatcher()
    
    // Request API task
    private var task: DataRequest?
    
    // Network enviroment for executing
    private var enviroment: NetworkEnviroment
    
    required init(enviroment: NetworkEnviroment = NetworkEnviroment.shared) {
        self.enviroment = enviroment
    }
    
    func execute(request: Request, retry: Int? = 0) throws -> Promise<Response> {
        // Cancel previous task
        cancel()
        // Execute the request
        let content = prepareContentFor(request: request)
        let op = Promise<Response>.init(in: .background, { resolve, _ , _ in
            self.task = Alamofire.request(content.fullUrl,
                                          method: content.method,
                                          parameters: content.parameters,
                                          encoding: content.encoding,
                                          headers: content.httpHeaders).responseJSON(completionHandler: { data in
                let response = Response(data, for: request)
                resolve(response)
            })
        })
        guard let retryAttempts = retry else { return op }
        return op.retry(retryAttempts)
    }
    
    func cancel() {
        task?.cancel()
        task = nil
    }
    
    func prepareContentFor(request: Request) -> (fullUrl: String, method: HTTPMethod, httpHeaders: HTTPHeaders?, parameters: Parameters?, encoding: URLEncoding) {
        let fullUrl = enviroment.host + "/" + request.path
        let encoding = enviroment.encoding
        let method = request.method
        var httpHeaders: HTTPHeaders = enviroment.headers
        if let requestHeader = request.headers {
            requestHeader.forEach {
                httpHeaders[$0.key] = $0.value
            }
        }
        var parameters: Parameters?
        switch request.parameters {
        case .body(let params):
            parameters = params
        case .url(let params):
            parameters = params
        }
        print("[ REQUEST INFORMATION ] ==========================")
        print(" - Full url: \(fullUrl)")
        print(" - Method: \(method)")
        print(" - HTTP Headers: \(httpHeaders)")
        print(" - Parameters: \(parameters ?? [:])")
        return (fullUrl: fullUrl, method: method, httpHeaders: httpHeaders, parameters: parameters, encoding: encoding)
    }
    
//    func prepareFor(request: Request) throws -> URLRequest {
//        let fullUrl = enviroment.host + "/" + request.path
//        var urlRequest = try URLRequest(url: fullUrl, method: request.method)
//
//        // Analyzing parameters
//        switch request.parameters {
//        case .body(let params):
//            if let params = params {
//                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
//            } else {
//                throw NetworkErrors.badInput
//            }
//        case .url(let params):
//            if let params = params as? [String: String] {
//                let queryParams = params.map({ (element) -> URLQueryItem in
//                    return URLQueryItem(name: element.key, value: element.value)
//                })
//                guard var components = URLComponents(string: fullUrl) else {
//                    throw NetworkErrors.badInput
//                }
//                components.queryItems = queryParams
//                urlRequest.url = components.url
//            } else {
//                throw NetworkErrors.badInput
//            }
//        }
//
//        // Add HTTP headers to url request
//        enviroment.headers.forEach {
//            if let value = $0.value as? String {
//                urlRequest.addValue(value, forHTTPHeaderField: $0.key)
//            }
//        }
//        request.headers?.forEach {
//            if let value = $0.value as? String {
//                urlRequest.addValue(value, forHTTPHeaderField: $0.key)
//            }
//        }
//
//        print("[ REQUEST INFORMATION ] ==========================")
//        print(" - Full url: \(urlRequest.url?.absoluteString ?? "-")")
//        print(" - Method: \(urlRequest.httpMethod ?? "-")")
//        print(" - HTTP Headers: \(urlRequest.allHTTPHeaderFields ?? [:])")
//        do {
//            let data = urlRequest.httpBody ?? Data()
//            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
//            print(" - Parameters: \(jsonObject)")
//        } catch { }
//        return urlRequest
//    }
}
