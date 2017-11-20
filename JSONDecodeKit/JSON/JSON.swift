//
//  YumeJSON.swift
//  JsonTest
//
//  Created by Yume on 2016/11/3.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

public struct JSON {
    internal var data:Any?
    internal lazy var traceKeypath:[String] = []
    internal var isTraceKeypath:Bool
    
    public init(data:Data,isTraceKeypath:Bool = false) {
        self.data = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])
        self.isTraceKeypath = isTraceKeypath
    }
    
    public init(any:Any,isTraceKeypath:Bool = false) {
        self.data = any
        self.isTraceKeypath = isTraceKeypath
    }
    
    internal var keypath:String {
        get {
            var temp = self
            return temp.traceKeypath.joined(separator: "")
        }
    }
}
