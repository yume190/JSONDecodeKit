import Foundation

// Title: An easy way to convert Swift structs to JSON
// source: http://codelle.com/blog/2016/5/an-easy-way-to-convert-swift-structs-to-json/


public protocol JSONRepresentable {
    var JSONRepresentation: Any { get }
}

public protocol JSONSerializable: JSONRepresentable {}

extension JSONSerializable {
    public var JSONRepresentation: Any {
        var representation = [String: Any]()
        
        for case let (label?, value) in Mirror(reflecting: self).children {
            switch value {
            case let value as JSONRepresentable:
                representation[label] = value.JSONRepresentation    
            default:
                // Ignore any unserializable properties
                representation[label] = value
                break
            }
        }
        
        return representation
    }
}

extension JSONSerializable {
    public func toJSON() -> String {
        let representation = JSONRepresentation
        
        guard JSONSerialization.isValidJSONObject(representation) else {
            return ""
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject:representation, options: [])
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
}
