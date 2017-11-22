//
//  YumeJSONError.swift
//  JsonTest
//
//  Created by Yume on 2016/10/27.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

public enum JSONDecodeError: Error {
    public struct BaseInfo {
        let keyPath:String
        let currentKey:String
        let json:JSON
        var description:String {
            return [
                "\tKeypath : \"\(keyPath)\"",
                "\tKey : \"\(currentKey)\""
//                "\tjson: \(json.data ?? "nil")"
            ].joined(separator: "\n")
        }
    }
    case keyNotFound(baseInfo:BaseInfo)
    case nullValue(baseInfo:BaseInfo)
    case typeMismatch(baseInfo:BaseInfo,expectType:Any,actualType:Any,value:Any)
    case specialCase(reason:String)
    
    static public func produceError<T> (targetType:T.Type, json:JSON, key:String) -> JSONDecodeError {
        let baseInfo = BaseInfo(keyPath: json.keypath, currentKey: key, json: json)
        guard let data = json[key].data else {
            return JSONDecodeError.keyNotFound(baseInfo: baseInfo)
        }
            
        if data is NSNull {
            return JSONDecodeError.nullValue(baseInfo: baseInfo)
        }
        
        return JSONDecodeError.typeMismatch(baseInfo: baseInfo, expectType: T.self, actualType: type(of:data),value: data)
    }
}

extension JSONDecodeError:CustomStringConvertible {
    public var description: String {
        switch self {
        case .keyNotFound(let baseInfo):
            return errorMessage(messageType: "Key Not Found::", baseInfo: baseInfo,
                                expectType: nil, actualType: nil, value: nil)
        case .nullValue(let baseInfo):
            return errorMessage(messageType: "Null Value Found At:", baseInfo: baseInfo,
                                expectType: nil, actualType: nil, value: nil)
        case .typeMismatch(let baseInfo, let expectType, let actualType,let value):
            return errorMessage(messageType: "Type Mismatch:", baseInfo: baseInfo,
                                expectType: expectType, actualType: actualType, value: value)
        case .specialCase(let reason):
            return reason
        }
    }
}

fileprivate func errorMessage(messageType: String, baseInfo:JSONDecodeError.BaseInfo,
                              expectType: Any?, actualType: Any?, value: Any?) -> String {
    let baseResult:String = [
        "",
        messageType,
        baseInfo.description
    ].joined(separator: "\n")
    guard let expectType = expectType, let actualType = actualType, let value = value else {
        return baseResult
    }
    
    return [
        baseResult,
        "\tExpected Type : \(expectType)",
        "\tActual Type : \(actualType)",
        "\tActual Value : \(value)",
    ].joined(separator: "\n")
}
