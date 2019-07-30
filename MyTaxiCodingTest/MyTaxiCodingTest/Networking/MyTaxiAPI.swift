//
//  MyTaxiAPI.swift
//  MyTaxiCodingTest
//
//  Created by Amit  Singh on 30/07/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation
import Moya

public var stubJsonPath = ""

public enum MyTaxiAPI {
    case taxiSearch(p1: Coordinate, p2: Coordinate)
}

extension MyTaxiAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://fake-poi-api.mytaxi.com")!
    }
    
    public var path: String {
        switch self {
        case .taxiSearch(p1: _, p2: _):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .taxiSearch(p1: _, p2: _):
            return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .taxiSearch(p1: _, p2: _):
            return StubResponse.fromJSONFile(filePath: stubJsonPath)
        }
    }
    
    public var task: Task {
        switch self {
        case .taxiSearch(let p1, let p2):
            let params: [String:Any] = ["p1Lat":p1.latitude, "p1Lon":p1.longitude,"p2Lat":p2.latitude, "p2Lon":p2.longitude]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

public var MyTaxiProvider = MoyaProvider<MyTaxiAPI>(
    endpointClosure: endpointClosure,
    requestClosure: requestClosure,
    plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)]
)

public func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let endpointClosure = { (target: MyTaxiAPI) -> Endpoint in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
    
    return defaultEndpoint
}

let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        // Modify the request however you like.
        done(.success(request))
    } catch {
         done(.failure(MoyaError.underlying(error, nil)))
    }
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

