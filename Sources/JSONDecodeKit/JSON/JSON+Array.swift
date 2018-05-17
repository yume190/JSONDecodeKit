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
    public func array<T: JSONDecodable>() throws -> [T] {
        return try self.jsonArray().compactMap { json in
            return try T.decode(json: json)
        }
    }
    
    public func array<T: RawRepresentable>() -> [T] where T.RawValue: PrimitiveType {
        return self.jsonArray().compactMap {
            guard let value = try? T.RawValue.decode(any: $0.data) else { return nil }
            return T(rawValue: value)
        }
    }
}
