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
            return
                "\nKey Not Found:\n" +
                    "\tKeypath : \"\(keyPath)\"\n" +
                    "\tKey : \"\(currentKey)\"\n" +
            "\tjson: \(json.data)"
        case .nullValue(let keyPath, let currentKey, let json):
            return
                "\nNull Value Found At:\n" +
                    "\tKeypath : \"\(keyPath)\"\n" +
                    "\tKey : \"\(currentKey)\"\n" +
            "\tjson: \(json.data)"
        case .typeMismatch(let keyPath, let currentKey, let expectType, let actualType,let value, let json):
            return
                "\nType Mismatch:\n" +
                    "\tKeypath : \"\(keyPath)\"\n" +
                    "\tKey : \"\(currentKey)\"\n" +
                    "\tExpected Type : \(expectType)\n" +
                    "\tActual Type : \(actualType)\n" +
                    "\tActual Value : \(value)\n" +
            "\tjson: \(json.data)"
        case .specialCase(let reason):
            return reason
        }
    }
}
