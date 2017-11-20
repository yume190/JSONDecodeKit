//
//  JSON+RawRepresentable
//  JsonTest
//
//  Created by Yume on 2016/10/27.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

extension JSON {
    static public func <|? <T:RawRepresentable> (json:JSON,key:String) -> T? where T.RawValue:PrimitiveType {
        if let value = T.RawValue.decode(any: json[key].data) {
            let enumValue = T(rawValue: value)
            return enumValue
        }
        return nil
    }
    
    static public func <| <T:RawRepresentable> (json:JSON,key:String) throws -> T where T.RawValue:PrimitiveType {
        guard let r:T = json <|? key else {
            throw JSONDecodeError.produceError(targetType: T.self, json: json, key: key)
        }
        
        return r
    }
    
    static public func <|| <T:RawRepresentable>(json:JSON,key:String) -> [T] where T.RawValue:PrimitiveType {
        return json.array()
    }
}

//// MARK: Lazy Man Operators
//extension JSON {
//    static public func <||| <T:RawRepresentable> (json:JSON,key:String) -> T? where T.RawValue:PrimitiveType {
//        return json <|? key
//    }
//    
//    static public func <||| <T:RawRepresentable> (json:JSON,key:String) throws -> T where T.RawValue:PrimitiveType {
//        return try json <| key
//    }
//    
//    static public func <||| <T:RawRepresentable>(json:JSON,key:String) -> [T] where T.RawValue:PrimitiveType {
//        return json <|| key
//    }
//}

