## 0.0.1

- Initial version, created by Stagehand

## 0.0.6+3

- change named rule of nested class name, prefix top-level class name to every nested class

- update json serialize/deserialize interface of generated bean:

    + factory Bean.fromJson(dynamic json);
    
    + dynamic toJson();

> dynamic must be list(json array) or map(json object), if neither is then an error will be thrown
