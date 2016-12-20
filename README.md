JSONDecodeKit
==========

A light weight JSON Mapper.

Inspired by some JSON libraries :

 * [Argo](https://github.com/thoughtbot/Argo)
 * [Himotoki](https://github.com/ikesyo/Himotoki)
 * [Marshal](https://github.com/utahiosmac/Marshal)

According to [JSONShootout](https://github.com/bwhiteley/JSONShootout), we testing the json mapping speed, and we have same performance with Marshal.

## Usage

```swift
struct Sample:JSONDecodable {
    let temp:Int
    static func decode(_ dic: JSON) throws -> Sample {
        return try Sample(temp: dic <| "temp")
    }
}

let json = JSON(any: ["temp":1234])
let sample:Sample? = try? Sample.decode(json)
```

---

## Protocols

#### PrimitiveType 

PrimitiveType focus on casting type and transform from string 

 * Casting Type
```swift
return self as? T
// return 1 as? Int
// return "1" as? Int
```
 * Transform From String (`String -> T`)
```swift
return Int("1")     // "1" -> 1
return Int("true")  // "true" -> true
```

 * Support Types
```swift
Int     Int8    Int16   Int32   Int64
UInt    UInt8   UInt16  UInt32  UInt64
Float   Double
Bool
String
URL
```

#### JSONDecodable

JSONDecodable is the protocol, mapping `JSON` to your customize struct.

---

#### Operators

|Operator|Decode element|
|:------:|:------------:|
| `<|?`  | `T?` |
| `<|`   | `T` |
| `<||`  | `[T]` |
| `<|||` | `T?`,`T`,`[T]` |
