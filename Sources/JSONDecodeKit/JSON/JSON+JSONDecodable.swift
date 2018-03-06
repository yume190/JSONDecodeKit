//
//  JSON+JSONDecodable
//  JsonTest
//
//  Created by Yume on 2016/10/27.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

extension JSON {
    static public func <|? <T:JSONDecodable>(json:JSON,key:String) -> T? {
        return try? T.decode(json: json[key])
    }
    
    static public func <| <T:JSONDecodable> (json:JSON,key:String) throws -> T {
        guard let r:T = json <|? key else {
            throw JSONDecodeError.produceError(targetType: T.self, json: json, key: key)
        }
        
        return r
    }
    
    static public func <|| <T:JSONDecodable>(json:JSON,key:String) throws -> [T] {
        return try json[key].array()
    }
}
