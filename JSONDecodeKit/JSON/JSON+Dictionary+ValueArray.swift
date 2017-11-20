//
//  JSON+DictionaryArray.swift
//  JSONDecodeKit
//
//  Created by Yume on 2017/11/20.
//  Copyright © 2017年 Yume. All rights reserved.
//

import Foundation

// MARK: Get [Key:[Value]]
extension JSON {
        public func dictionaryValueArray<Key,Value:PrimitiveType>() -> [Key:[Value]] {
            return self.toDictionaryValueArray { (any:Any) -> [Value] in
                JSON(any: any).array()
            }
        }
    
    public func dictionaryValueArray<Key,Value:JSONDecodable>() -> [Key:[Value]] {
        return self.toDictionaryValueArray { (any:Any) -> [Value] in
            (try? JSON(any: any).array()) ?? []
        }
    }
    
    public func dictionaryValueArray<Key,Value:RawRepresentable>() -> [Key:[Value]] where Value.RawValue:PrimitiveType {
        return self.toDictionaryValueArray { (any:Any) -> [Value] in
            JSON(any: any).array()
        }
    }
    
    private func toDictionaryValueArray<Key,Value>(valueTransform:(Any) -> [Value]) -> [Key:[Value]] {
        guard let dic = self.data as? NSDictionary else {
            return [Key:[Value]]()
        }
        
        return dic.reduce([Key:[Value]]()) { (result:[Key:[Value]], set:(key: Any, value: Any)) -> [Key:[Value]] in
            guard let key = set.key as? Key else {
                    return result
            }
            
            let values = valueTransform(set.value)
            
            var result = result
            result[key] = values
            return result
        }
    }
}
