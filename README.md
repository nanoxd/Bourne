# Bourne
[![Build Status](https://travis-ci.org/nanoxd/Bourne.svg?branch=master)](https://travis-ci.org/nanoxd/Bourne)

## Installation

### CocoaPods

Add the line `pod "Bourne"` to your `Podfile`

### Carthage

Add the line `github "nanoxd/Bourne"` to your `Cartfile`

### Manual

Clone the repo and drag the file `Bourne.swift` into your Xcode project.

#### Swift Package Manager

Add the line `.Package(url: "https://github.com/nanoxd/Bourne.git", majorVersion: 1)` to your `Package.swift` file.

## Usage

### Conforming to Mappable

```swift
import Bourne

struct Person {
  let firstName: String
  let lastName: String
  let age: Int?
}

extension Person: Mappable {
  static func decode(_ j: JSON) throws -> Person {
    return Person(
      firstName: try j.from("firstName"),
      lastName: try j.from("lastName", or: "Medina"),
      age: try? j.from("age")
    )
  }
}
```


### Optional Values

Bourne has two ways of working with Optional values, `try?` and adding a default value to `from`.

First, let's look at how to decode a value that is sometimes included in our JSON:

```json
{
  "people": [
    {
      "firstName": "Jose",
      "lastName": null
    },
    {
      "firstName": "Maria",
      "lastName": "Sanchez",
      "age": 20
    }
  ]
}
```

```swift
try? j.from("age")
```
