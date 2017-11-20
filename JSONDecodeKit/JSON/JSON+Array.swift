//
//  JSON+Array.swift
//  JSONDecodeKit
//
//  Created by Yume on 2017/11/20.
//  Copyright © 2017年 Yume. All rights reserved.
//

import Foundation

extension JSON {
    public func jsonArray() -> [JSON] {
        guard let array = self.data as? NSArray else { return [] }
        
        var r:[JSON] = []
        for index in 0..<array.count {
            r.append(self[index])
        }
        
        return r
    }
}

extension JSON {
    public func array<T:PrimitiveType>() -> [T] {
        return self.jsonArray().flatMap {T.decode(any: $0.data)}
    }
    
    public func array<T:JSONDecodable>() throws -> [T] {
        return try self.jsonArray().flatMap { json in
            return try T.decode(json: json)
        }
    }
    
    public func array<T:RawRepresentable>() -> [T] where T.RawValue:PrimitiveType {
        return self.jsonArray().flatMap {
            if let value = T.RawValue.decode(any: $0.data) {
                let enumValue = T(rawValue: value)
                return enumValue
            }
            return nil
        }
    }
}
