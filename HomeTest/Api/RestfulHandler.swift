//
//  RestfulHandler.swift
//  HomeTest
//
//  Created by Steven on 8/8/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import RxAlamofire
import RxSwift
import RxCocoa

enum HeaderLabel: String {
    case contentType = "Content-Type";
}

enum ContentType: String {
    case textPlain = "text/plain";
    case applicationJson = "application/json";
}

enum ApiResult<Value, String>{
    case success(Value)
    case failure(String)
    
    init (value: Value) {
        self = .success(value)
    }
    
    init (error: String) {
        self = .failure(error)
    }
}

class RestfulHandler {
    private var requestUrl: RequestUrl!
    private var headers: HTTPHeaders = HTTPHeaders()
    private var parameters: Parameters?
    private let session = Session.default
    private let disposeBag = DisposeBag()
    
    init(requestUrl: RequestUrl, parameters: Parameters? = nil) {
        self.requestUrl = requestUrl
        self.parameters = parameters
        self.setUpHeaders()
    }
    
    private func setUpHeaders() {
        self.headers.add(HTTPHeader(name: HeaderLabel.contentType.rawValue, value: ContentType.applicationJson.rawValue))
    }
    
    func request<T: Decodable>(ofType: T.Type) -> Observable<ApiResult<T, String>> {
        return self.session.rx
            .request(self.requestUrl.requestMethod, self.requestUrl.getUrl(), parameters: self.parameters, encoding: URLEncoding.default, headers: self.headers)
            .catchError({ (error) -> Observable<DataRequest> in
                AppHelper.displayError(title: "Error", message: error.localizedDescription)
                return Observable.never()
            })
            .responseData()
            .map { (response, data) -> ApiResult<T, String> in
                if 200...299 ~= response.statusCode {
                    if let object: T = JsonHelper.parseJson(data: data) {
                        return .success(object)
                    } else {
                        let errorMessage = "Request Error"
                        return .failure(errorMessage)
                    }
                } else {
                    let errorMessage = "Server Error"
                    return .failure(errorMessage)
                }
        }
    }
}
