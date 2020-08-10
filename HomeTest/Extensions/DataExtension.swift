//
//  DataExtension.swift
//  HomeTest
//
//  Created by Steven on 8/8/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import Foundation

extension Data {
    func json() -> [String : Any] {
        do {
            if let json = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String : Any] {
                return json
            }
            
            return [:]
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        
        return [:]
    }
    
    func arrayJson() -> [[String : Any]] {
        do {
            if let json = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [[String : Any]] {
                return json
            }
            
            return []
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        
        return []
    }
}
