//
//  CardView.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 07/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

open class BaseApiClient {
    fileprivate let BASE_URL = "dfsdfdf"
    func requestApiWithoutHeader<T>(url: String,
                                    method: HTTPMethod,
                                    params: Parameters,
                                    value: T.Type) -> Observable<T> where T : Codable {
        let headers: HTTPHeaders = ["Authorization":""]
        let decoder = JSONDecoder()
       return  Observable<T>.create{ (observer) -> Disposable in
            let request = Alamofire.request(url , method: method, parameters: params, headers: headers).responseJSON{ response in
                switch response.result {
                case .success :
                    if 200 ... 299 ~= response.response?.statusCode ?? 500 {
                        let data = response.data!
                        print("Data",data)
                        let returndata  = try! decoder.decode(T.self, from: data)
                        observer.onNext(returndata)
                        observer.onCompleted()
                        
                    }else{
                        let error = response.data!
                        let returndata  = try! decoder.decode(ErrorResponse.self, from: error)
                        observer.onError(returndata as! Error)
                    }
                case .failure(let err):
                    observer.onError(err)
                }
            }
            
            return Disposables.create(with: {
                request.cancel()
            })
        }
        
    }
}
