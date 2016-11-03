//
//  YumeJSONError.swift
//  JsonTest
//
//  Created by Yume on 2016/10/27.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

public enum YumeError: Error {
    case keyNotFound(keyPath:String,curruntKey:String)
    case nullValue(keyPath:String,curruntKey:String)
    case typeMismatch(keyPath:String,curruntKey:String,expectType:Any,actualType:Any,value:Any)
}

extension YumeError:CustomStringConvertible {
    public var description: String {
        switch self {
        case .keyNotFound(let keyPath, let currentKey):
            return
                "\nKey Not Found:\n" +
                "\tKeypath : \"\(keyPath)\"\n" +
                "\tKey : \"\(currentKey)\"\n"
        case .nullValue(let keyPath, let currentKey):
            return
                "\nNull Value Found At:\n" +
                "\tKeypath : \"\(keyPath)\"\n" +
                "\tKey : \"\(currentKey)\"\n"
        case .typeMismatch(let keyPath, let currentKey, let expectType, let actualType,let value):
            return
                "\nType Mismatch:\n" +
                "\tKeypath : \"\(keyPath)\"\n" +
                "\tKey : \"\(currentKey)\"\n" +
                "\tExpected Type : \(expectType)\n" +
                "\tActual Type : \(actualType)\n" +
                "\tActual Value : \(value)\n"
        }
    }
}
