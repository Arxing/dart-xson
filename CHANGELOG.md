## 0.0.1

- Initial version, created by Stagehand

## 0.0.6+3

- change named rule of nested class name, prefix top-level class name to every nested class

- update json serialize/deserialize interface of generated bean:

    + factory Bean.fromJson(dynamic json);
    
    + dynamic toJson();

> dynamic must be list(json array) or map(json object), if neither is then an error will be thrown

## 0.0.6+4

- new rule of named mode, all illegal character will be replaced with "_"

ex: 

"an-apple" - "an\_apple" - "anApple"

"an..apple****pie" - "an\_apple\_pie" - "anApplePie"

"100...test" - "$100\_test" - "$100Test"

## 0.0.6+5

- fixed bugs

## 0.0.7

- type auto transformer of all property

- now you can specific property type at json source just generate some tag anywhere like this:
```json
{
    "a":100,
    "b":[
        {
            "c": 200
        }
    ]
}
//@.a=String
//@.b[].c=String
```

## 0.0.7+5

- fixed bugs of nested List parsed

## 0.0.8

- fixed transformer of List

## 0.0.8+1

- bug fixed

## 0.0.8+2

- bug fixed

## 0.0.8+3

- bug fixed

## 1.0.0

- Now xson is a pure library for resolving json, bean generating will move to xson_builder

## 1.0.1

#### JsonElement

- new getter `isInt`, `isDouble`, `isBool` and `isString` 

- new getter `type`, can get JsonType of JsonElement 

#### JsonArray

- remove getter `asNum`, `asString`, `asDouble`, `asInt` and `asBool` 

#### JsonObject

- new function `addProperty`, can add any type value

#### JsonPrimitive

- new named constructor `ofInt` and `ofDouble`

#### JsonInfo

- fixed `==` operator function

- new `toString()`, it will return md5



## 1.0.2

- new `parent`, `ancestor` and `isAncestor` in `JsonElement`, you can use these to traversal any node on a json tree simply.


## 1.0.3

- new `nativeType` in `JsonType`

## 1.0.4

- `JsonInfo` support `JsonElement` parsed