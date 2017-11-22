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
    
    public struct ExtraInfo {
        let expectType:Any
        let actualType:Any
        let value:Any
        var description:String {
            return [
                "\tExpected Type : \(expectType)",
                "\tActual Type : \(actualType)",
                "\tActual Value : \(value)"
            ].joined(separator: "\n")
        }
    }
    
    case keyNotFound(baseInfo:BaseInfo)
    case nullValue(baseInfo:BaseInfo)
    case typeMismatch(baseInfo:BaseInfo,extraInfo:ExtraInfo)
    case specialCase(reason:String)
    
    static public func produceError<T> (targetType:T.Type, json:JSON, key:String) -> JSONDecodeError {
        let baseInfo = BaseInfo(keyPath: json.keypath, currentKey: key, json: json)
        guard let data = json[key].data else {
            return JSONDecodeError.keyNotFound(baseInfo: baseInfo)
        }
            
        if data is NSNull {
            return JSONDecodeError.nullValue(baseInfo: baseInfo)
        }
        
        let extraInfo = ExtraInfo(expectType: T.self, actualType: type(of:data), value: data)
        return JSONDecodeError.typeMismatch(baseInfo: baseInfo, extraInfo: extraInfo)
    }
}

extension JSONDecodeError:CustomStringConvertible {
    public var description: String {
        switch self {
        case .keyNotFound(let baseInfo):
            return errorMessage(messageType: "Key Not Found::", baseInfo: baseInfo, extraInfo: nil)
        case .nullValue(let baseInfo):
            return errorMessage(messageType: "Null Value Found At:", baseInfo: baseInfo, extraInfo: nil)
        case .typeMismatch(let baseInfo, let extraInfo):
            return errorMessage(messageType: "Type Mismatch:", baseInfo: baseInfo, extraInfo: extraInfo)
        case .specialCase(let reason):
            return reason
        }
    }
    
    private func errorMessage(messageType: String, baseInfo: BaseInfo, extraInfo: ExtraInfo?) -> String {
        return [
            "",
            messageType,
            baseInfo.description,
            extraInfo?.description
        ].flatMap {$0}.joined(separator: "\n")
    }
}
