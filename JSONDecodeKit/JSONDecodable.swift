//
//  JSONDecodable.swift
//  JSONDecodeKit
//
//  Created by Yume on 2017/11/17.
//  Copyright © 2017年 Yume. All rights reserved.
//

import Foundation

public protocol JSONDecodable {
    static func decode(json: JSON) throws -> Self
}
