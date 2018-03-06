//
//  JSON+Subscript.swift
//  JSONDecodeKit
//
//  Created by Yume on 2017/11/20.
//  Copyright © 2017年 Yume. All rights reserved.
//

import Foundation

extension JSON {
    public subscript(key:String) -> JSON {
        var copy = self
        if isTraceKeypath {
            copy.traceKeypath.append("." + key)
        }
        copy.data = (self.data as? NSDictionary)?[key]
        return copy
    }
    
    public subscript(index:Int) -> JSON {
        var copy = self
        if isTraceKeypath {
            copy.traceKeypath.append("[\(index)]")
        }
        copy.data = (self.data as? NSArray)?[index]
        return copy
    }
}
