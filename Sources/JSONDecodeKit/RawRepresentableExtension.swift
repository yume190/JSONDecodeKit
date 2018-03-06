//
//  RawRepresentableExtension.swift
//  JSONDecodeKit
//
//  Created by Yume on 2017/11/17.
//  Copyright © 2017年 Yume. All rights reserved.
//

import Foundation

//extension RawRepresentable {
//    associatedtype RawValue
//}

extension RawRepresentable {
    public static func decode(any: Any?) throws -> Self {
        guard let data = any as? Self.RawValue, let result = Self(rawValue: data) else {
            throw JSONDecodeError.specialCase(reason: "...")
        }
        return result
    }
    
    public static func decode(json: JSON) throws -> Self {
        return try decode(any: json.data)
    }
}
