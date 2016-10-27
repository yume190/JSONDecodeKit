//
//  YumeJSONError.swift
//  JsonTest
//
//  Created by Yume on 2016/10/27.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

//@objc
public enum YumeError:Int, Error {
    case WrongType = 666
}

//public enum MarshalError: Error, CustomStringConvertible {
//    
//    case keyNotFound(key: KeyType)
//    case nullValue(key: KeyType)
//    case typeMismatch(expected: Any, actual: Any)
//    case typeMismatchWithKey(key: KeyType, expected: Any, actual: Any)
//    
//    public var description: String {
//        switch self {
//        case let .keyNotFound(key):
//            return "Key not found: \(key.stringValue)"
//        case let .nullValue(key):
//            return "Null Value found at: \(key.stringValue)"
//        case let .typeMismatch(expected, actual):
//            return "Type mismatch. Expected type \(expected). Got '\(actual)'"
//        case let .typeMismatchWithKey(key, expected, actual):
//            return "Type mismatch. Expected type \(expected) for key: \(key.stringValue). Got '\(actual)'"
//        }
//    }
//}
