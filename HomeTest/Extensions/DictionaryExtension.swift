//
//  DictionaryExtension.swift
//  HomeTest
//
//  Created by Steven on 8/8/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import Foundation

extension Dictionary {
    func json() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(data: jsonData, encoding: .utf8) ?? ""
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        
        return ""
    }
}
