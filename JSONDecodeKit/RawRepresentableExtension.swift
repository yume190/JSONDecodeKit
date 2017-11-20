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
    static func decode(any: Any?) -> Self? {
        guard let data = any as? Self.RawValue else {
            return nil
        }
        return Self(rawValue: data)
    }
    
    // !!!!!!!
    static func decode(json: JSON) -> Self? {
        return decode(any: json.data)
    }
}

