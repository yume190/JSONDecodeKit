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
        if let value = try? T.RawValue.decode(any: json[key].data) {
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
        return json[key].array()
    }
}

@available(swift 4.1)
extension Array: JSONDecodable where Element: RawRepresentable, Element.RawValue: PrimitiveType {
    public static func decode(json: JSON) throws -> Array<Element> {
        let result: [Element] = json.array()
        return result
    }
}
