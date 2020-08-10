//
//  JsonHelper.swift
//  HomeTest
//
//  Created by Steven on 8/8/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import Foundation


class JsonHelper {
    static func encodeJson<T: Encodable>(object: T) -> [String : Any] {
        do {
            let jsonData = try JSONEncoder().encode(object)
            return jsonData.json()
        } catch let parsingError {
            print("Error", parsingError)
        }
        
        return [:]
    }
    
    static func encodeArrayJson<T: Encodable>(object: T) -> [[String : Any]] {
        do {
            let jsonData = try JSONEncoder().encode(object)
            return jsonData.arrayJson()
        } catch let parsingError {
            print("Error", parsingError)
        }
        
        return []
    }
    
    static func parseJson<T: Decodable>(data: Data) -> T? {
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            let model = try decoder.decode(T.self, from:
                data)
            return model
        } catch let parsingError {
            print("Error", parsingError)
        }
        
        return nil
    }
}
