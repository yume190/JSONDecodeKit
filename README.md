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

#### Operators

|Operator|Decode element|
|:------:|:------------:|
| `<|?`  | `T?` |
| `<|`   | `T` |
| `<||`  | `[T]` |
| `<|||` | `T?`,`T`,`[T]` |
