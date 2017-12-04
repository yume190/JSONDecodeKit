//
//  Direction.swift
//  BusApp
//
//  Created by Yume on 2016/12/21.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation
import CoreLocation
@testable import JSONDecodeKit

struct Location {
    let name:String
    let lat:String
    let lng:String
    
    func location() -> CLLocationCoordinate2D {
        guard let _lat = Double(lat),let _lng = Double(lng) else {
            return kCLLocationCoordinate2DInvalid
        }
        return CLLocationCoordinate2D(latitude: _lat, longitude: _lng)
    }
}

extension Location: JSONDecodable {
    static func decode(json: JSON) throws -> Location {
        return try Location(name: json <| "name", lat: json <| "lat", lng: json <| "lng")
    }
}

struct Route {
    let from: Location
    let to:Location
    let departure_time:String //"17:30 PM",
    let arrival_time:String// "18:49 PM",
    let duration:String// "1 小時 18 分",
    let distance:Double// 14942.33,
    let fare:String?// null,
    let overview_polyline:String
    let steps:[Step]
}

extension Route: JSONDecodable {
    static func decode(json: JSON) throws -> Route {
        let steps:[Step] = try json <|| "steps"
        return try Route(
            from: json <| "from" ,
            to: json <| "to" ,
            departure_time: json <| "departure_time" ,
            arrival_time: json <| "arrival_time" ,
            duration: json <| "duration" ,
            distance: json <| "distance" ,
            fare: json <|? "fare" ,
            overview_polyline: json <| "overview_polyline" ,
            steps: steps
        )
    }
}

struct Step {
    let polyline:String
    let from:Location
    let msg:String
    let travel_mode:String
}

extension Step: JSONDecodable {
    static func decode(json: JSON) throws -> Step {
        return try Step(
            polyline: json <| "polyline",
            from: json <| "from",
            msg: json <| "msg",
            travel_mode: json <| "travel_mode"
        )
    }
}

