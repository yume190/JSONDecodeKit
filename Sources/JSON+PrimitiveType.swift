//
//  JSON+PrimitiveType
//  JsonTest
//
//  Created by Yume on 2016/10/27.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

extension JSON {
    static public func <|? <T:PrimitiveType>(json:JSON,key:String) -> T? {
        return T.decode(any: json[key].data)
    }

    static public func <| <T:PrimitiveType> (json:JSON,key:String) throws -> T {
        guard let r:T = json <|? key else {
            throw JSONDecodeError.produceError(targetType: T.self, json: json, key: key)
        }

        return r
    }

    static public func <|| <T:PrimitiveType>(json:JSON,key:String) -> [T] {
        return json[key].array()
    }
}

// MARK: Lazy Man Operators
extension JSON {
    static public func <||| <T:PrimitiveType>(json:JSON,key:String) -> T? {
        return json <|? key
    }

    static public func <||| <T:PrimitiveType>(json:JSON,key:String) throws -> T {
        return try json <| key
    }

    static public func <||| <T:PrimitiveType>(json:JSON,key:String) -> [T] {
        return json <|| key
    }
}



