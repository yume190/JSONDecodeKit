//
//  Program.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 5/17/16.
//  Copyright © 2016 Bart Whiteley. All rights reserved.
//

import Foundation
@testable import JSONDecodeKit

public struct Program:Codable {

    private enum CodingKeys:String, CodingKey {
        case title = "Title"
        case description = "Description"
        case subtitle = "SubTitle"
        case recording = "Recording"
        case season = "Season"
        case episode = "Episode"
    }
    
    let title:String
//    let chanId:String
// Date parsing is slow. Remove dates to better measure performance.
//    let startTime:NSDate
//    let endTime:NSDate
    let description:String?
    let subtitle:String?
    let recording:Recording
    let season:String?
    let episode:String?
}

extension Program: JSONDecodable {
    public static func decode(json: JSON) throws -> Program {
        return try Program(
            title: json <| "Title",
            description: json <|? "Description",
            subtitle: json <|? "SubTitle",
            recording: json <| "Recording",
            season: json <|? "Season",
            episode: json <|? "Episode"
        )
    }
}

