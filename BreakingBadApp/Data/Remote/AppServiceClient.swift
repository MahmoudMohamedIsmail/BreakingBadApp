//
//  APIManager.swift
//
//
//

import Foundation
import Alamofire
import RxSwift

protocol AppServiceClientProtocol {
    func performRequest<T>(_ object: T.Type, serviceGateway: Gateway)-> Observable<T> where T:Decodable
    func cancelPreviousNetworkCall()
}

class AppServiceClient: AppServiceClientProtocol {
    
    func performRequest<T>(_ object: T.Type, serviceGateway: Gateway) -> Observable<T> where T : Decodable {
        return Observable.create { (observer) -> Disposable in
            AF.request(serviceGateway)
                .validate()
                .responseJSON{ (response) in
                    switch response.result{
                    case .success:
                        do {
                            let responseModel = try JSONDecoder().decode(T.self, from: response.data!)
                            observer.onNext(responseModel)
                            
                        } catch let error{
                            observer.onError(error)
                        }
                    case let .failure(error):
                        if let statusCode = response.response?.statusCode,
                           let reason = ServiceError(rawValue: statusCode){
                            observer.onError(reason)
                        }
                        observer.onError(error)
                    }
                }.resume()
            return Disposables.create()
        }
    }
    
    func cancelPreviousNetworkCall() {
        AF.session.getAllTasks(completionHandler: {$0.forEach{$0.cancel()}})
    }
}
