//
//  Network.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import SwiftyBeaver
import RxSwift

final class NetworkService: Service {

    typealias JSON = [String: Any]

    private static var provider: MoyaProvider<HttpRequest> {
        let logger = NetworkLoggerPlugin(verbose: false, output: Log.moyaLog)
        return MoyaProvider<HttpRequest>(plugins: [logger])
    }

    override func serviceDidLoad() {

    }
    
    func request<T: Model>(_ route: HttpRequest, decodeAs type: T.Type) -> Single<T> {
        return request(route).flatMap { data in
            return Single<T>.create { event in
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let model = try decoder.decode(type, from: data)
                    event(.success(model))
                } catch {
                    SwiftyBeaver.error(JSONError.decodingFailed)
                    event(.error(JSONError.decodingFailed))
                }
                return Disposables.create()
            }
        }
    }
    
    func requestJSON(_ route: HttpRequest) -> Single<JSON> {
        return request(route).flatMap { data in
            return Single<JSON>.create { event in
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    guard let json = jsonObject as? JSON else {
                        throw JSONError.serializationFailed
                    }
                    event(.success(json))
                } catch {
                    SwiftyBeaver.error(JSONError.serializationFailed)
                    event(.error(JSONError.serializationFailed))
                }
                return Disposables.create()
            }
        }
    }
    
    func request(_ route: HttpRequest) -> Single<Data> {
        return Single<Data>.create { event in
            let queue = DispatchQueue.global(qos: route.priority)
            NetworkService.provider.request(route, callbackQueue: queue) { result in
                switch result {
                case .success(let response):
                    do {
                        let data = try response.filterSuccessfulStatusCodes().data
                        event(.success(data))
                    } catch (let error) {
                        SwiftyBeaver.error(error)
                        event(.error(error))
                    }
                case .failure(let error):
                    SwiftyBeaver.error(error)
                    event(.error(error))
                }
            }
            return Disposables.create()
        }.observeOn(MainScheduler.asyncInstance)
    }
}
