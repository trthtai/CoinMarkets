//
//  RequestUrl.swift
//  HomeTest
//
//  Created by Steven on 8/7/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import Foundation
import Alamofire

struct RequestUrl {
    var uri: String
    var host: String
    var requestMethod: HTTPMethod
    
    public func getUrl() -> String {
        return self.host.appending(self.uri)
    }
}
