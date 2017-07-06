//
//  YumeJSONError.swift
//  JsonTest
//
//  Created by Yume on 2016/10/27.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

public enum JSONDecodeError: Error {
    case keyNotFound(keyPath:String,curruntKey:String,json:JSON)
    case nullValue(keyPath:String,curruntKey:String,json:JSON)
    case typeMismatch(keyPath:String,curruntKey:String,expectType:Any,actualType:Any,value:Any,json:JSON)
    case specialCase(reason:String)
}

extension JSONDecodeError:CustomStringConvertible {
    public var description: String {
        switch self {
        case .keyNotFound(let keyPath, let currentKey, let json):
            return [
                "",
                "Key Not Found:",
                "\tKeypath : \"\(keyPath)\"",
                "\tKey : \"\(currentKey)\"",
                "\tjson: \(json.data ?? "nil")",
            ].joined(separator: "\n")
        case .nullValue(let keyPath, let currentKey, let json):
            return [
                "",
                "Null Value Found At:",
                "\tKeypath : \"\(keyPath)\"",
                "\tKey : \"\(currentKey)\"",
                "\tjson: \(json.data ?? "nil")",
            ].joined(separator: "\n")
        case .typeMismatch(let keyPath, let currentKey, let expectType, let actualType,let value, let json):
            return [
                "",
                "Type Mismatch:",
                "\tKeypath : \"\(keyPath)\"",
                "\tKey : \"\(currentKey)\"",
                "\tExpected Type : \(expectType)",
                "\tActual Type : \(actualType)",
                "\tActual Value : \(value)",
                "\tjson: \(json.data ?? "nil")",
            ].joined(separator: "\n")
        case .specialCase(let reason):
            return reason
        }
    }
}
