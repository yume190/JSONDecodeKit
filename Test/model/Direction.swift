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

struct Location:JSONDecodable,JSONEncodable {
    let name:String
    let lat:String
    let lng:String
    
    static func decode(json: JSON) throws -> Location {
        return try Location(name: json <| "name", lat: json <| "lat", lng: json <| "lng")
    }
    
    static func encode(_ json: Location) -> String {
        return JSONEncoder.encode(strings:
            json.name <| "name", json.lat <| "lat", json.lng <| "lng"
        )
    }
    
    func location() -> CLLocationCoordinate2D {
        guard let _lat = Double(lat),let _lng = Double(lng) else {
            return kCLLocationCoordinate2DInvalid
        }
        return CLLocationCoordinate2D(latitude: _lat, longitude: _lng)
    }
}

struct Route:JSONDecodable,JSONEncodable {
    let from: Location
    let to:Location
    let departure_time:String //"17:30 PM",
    let arrival_time:String// "18:49 PM",
    let duration:String// "1 小時 18 分",
    let distance:Double// 14942.33,
    let fare:String?// null,
    let overview_polyline:String
    let steps:[Step]
    
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
    
    static func encode(_ json: Route) -> String {
        return JSONEncoder.encode(strings:
            json.from <| "from" ,
            json.to <| "to" ,
            json.departure_time <| "departure_time" ,
            json.arrival_time <| "arrival_time" ,
            json.duration <| "duration" ,
            json.distance <| "distance" ,
            json.fare <|? "fare" ,
            json.overview_polyline <| "overview_polyline" ,
            json.steps <|| "steps"
        )
    }
}

struct Step:JSONDecodable,JSONEncodable {
    let polyline:String
    let from:Location
    let msg:String
    let travel_mode:String
    
    static func decode(json: JSON) throws -> Step {
        return try Step(
            polyline: json <| "polyline",
            from: json <| "from",
            msg: json <| "msg",
            travel_mode: json <| "travel_mode"
        )
    }
    
    static func encode(_ json: Step) -> String {
        return JSONEncoder.encode(strings:
            json.polyline <| "polyline",
            json.from <| "from",
            json.msg <| "msg",
            json.travel_mode <| "travel_mode"
        )
    }
}

