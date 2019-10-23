import 'dart:convert';
import 'dart:io';

import 'package:dartpoet/dartpoet.dart';
import 'package:named_mode/named_mode.dart';
import 'package:xfile/xfile.dart';
import 'package:xson/xson.dart';

List<String> _DART_KEYWORDS = [
  'abstract',
  'dynamic',
  'implements',
  'show',
  'as',
  'else',
  'import',
  'static',
  'assert',
  'enum',
  'in',
  'super',
  'async',
  'export',
  'interface',
  'switch',
  'await',
  'extends',
  'is',
  'sync',
  'break',
  'external',
  'library',
  'this',
  'case',
  'factory',
  'mixin',
  'throw',
  'catch',
  'false',
  'new',
  'true',
  'class',
  'final',
  'null',
  'try',
  'const',
  'finally',
  'on',
  'typedef',
  'continue',
  'for',
  'operator',
  'var',
  'covariant',
  'Function',
  'part',
  'void',
  'default',
  'get',
  'rethrow',
  'while',
  'deferred',
  'hide',
  'return',
  'with',
  'do',
  'if',
  'set',
  'yield'
];

class _Xson {
  Map<String, String> _extras = {};

  String _makeJsonBean(String fileName, String rootClassName, String jsonSource, {Map<String, String> extras}) {
    dynamic json;
    try {
      // decode string to json
      json = jsonDecode(jsonSource);
    } catch (e) {
      print('json decode error: $e');
      return '';
    }
    _extras.addAll(extras);

    // create file spec
    FileSpec fileSpec = _buildFileSpec(fileName);
    // iterate json all nodes and build file spec
    _iterateJsonEntity(json, null, fileSpec, rootClassName, 0, "");

    // build dart file from file spec
    DartFile dartFile = DartFile.fromFileSpec(fileSpec);
    return dartFile.outputContent();
  }

  File _makeJsonBeanToFile(String fileName, String rootClassName, String jsonSource, File outputFile) {
    return outputFile..writeAsStringSync(_makeJsonBean(fileName, jsonSource, rootClassName));
  }

  String _combineToNewKey(String key1, String key2) {
    return renameToOtherMode(key1, NamedMode.AnApple) + renameToOtherMode(key2, NamedMode.AnApple);
  }

  String _remakePropertyKey(String oldKey) {
    String newKey;
    if (_DART_KEYWORDS.contains(oldKey) || oldKey.startsWith(RegExp('[0-9]'))) {
      newKey = '\$$oldKey';
    } else {
      newKey = oldKey;
    }
    newKey = newKey.replaceAll(RegExp('[^0-9a-zA-Z_\$]+'), '_');
    newKey = renameTo__anApple(newKey);
    return newKey;
  }

  dynamic _iterateJsonEntity(dynamic entity, String ownKey, FileSpec fileSpec, String rootClassName, int depth, String selector) {
    rootClassName = renameToOtherMode(rootClassName, NamedMode.AnApple);
    bool isRoot = (ownKey == null);

    String className = renameTo__AnApple(rootClassName) + renameTo__AnApple(ownKey ?? '') + 'Bean';

//    print('depth=$depth, class=$className, root=$rootClassName');

    if (entity is Map) {
      // return a class spec while visit at map
      Map<String, dynamic> map = entity;

      // build class spec
      ClassSpec classSpec = _buildClassSpec(className, rootIsObject: true, keys: map.keys);
      // construct factory method
      _extendValueParserMethod(fileSpec, classSpec);
      // foreach elements in map entity
      for (var entry in map.entries) {
        String key = entry.key;
        dynamic val = entry.value;
        String newKey = _remakePropertyKey(key);

        PropertySpec propertySpec = _buildPropertySpecOfMap(newKey, val, ownKey, fileSpec, rootClassName, depth, "$selector.$key");
        MetaSpec metaSpec = _findJsonKeyOrCreate(propertySpec);
        if (key != newKey) metaSpec.parameters.add(ParameterSpec.named("name", isValue: true, value: key));
        // link property spec and class spec
        classSpec.properties.add(propertySpec);
      }
      // insert this class spec to file spec
      fileSpec.classes.add(classSpec);
      return classSpec;
    }

    if (entity is List) {
      // if root is a list, then wrap to object
      if (isRoot) {
        Map<String, dynamic> wrapped = {'data': entity};
        return _iterateJsonEntity(wrapped, ownKey, fileSpec, rootClassName, depth, "$selector[]");
      } else {
        List<dynamic> list = entity;
        // resolve the best generic type of list and generate recursively all class
        TypeToken type = _generateListTypeTokenRecursively(ownKey, list, fileSpec, rootClassName, depth, selector);
        return type;
      }
    }
  }

  TypeToken _generateListTypeTokenRecursively(
      String ownKey, List<dynamic> list, FileSpec fileSpec, String fileName, int depth, String selector) {
    if (list == null || list.isEmpty) return TypeToken.ofDynamic();
    List<TypeToken> elementTypes = [];
    Map<String, JsonInfo> cache = {};
    for (var element in list) {
      if (element == null) elementTypes.add(TypeToken.ofDynamic());
      if (isPrimitive(element?.runtimeType)) {
        elementTypes.add(TypeToken.parse(element));
      } else if (element is Map) {
        JsonInfo jsonInfo = JsonInfo.parse(element);
        String md5 = jsonInfo.md5;
        if (cache.containsKey(md5)) continue;
        cache[jsonInfo.md5] = jsonInfo;
        int index = list.indexOf(element);
        String newKey = '${ownKey ?? ''}\$${index}List';
        TypeToken typeToken;
        dynamic result = _iterateJsonEntity(element, newKey, fileSpec, fileName, depth, "${selector}[]");
        if (result is ClassSpec) {
          typeToken = TypeToken.ofName(result.className);
        } else {
          typeToken = result;
        }
        elementTypes.add(typeToken);
      } else if (element is List) {
        TypeToken componentType = _generateListTypeTokenRecursively(ownKey, element, fileSpec, fileName, depth, selector);
        elementTypes.add(TypeToken.ofListByToken(componentType));
      }
    }
    if (elementTypes.toSet().toList().length == 1) {
      return elementTypes[0];
    } else {
      return TypeToken.ofDynamic();
    }
  }

  FileSpec _buildFileSpec(String fileName) {
    FileSpec fileSpec = FileSpec.build();

    // import json convert
    fileSpec.dependencies.add(DependencySpec.import('dart:convert'));
    fileSpec.dependencies.add(DependencySpec.import('package:json_annotation/json_annotation.dart'));
    fileSpec.dependencies.add(DependencySpec.import("package:xson_utils/xson_utils.dart"));
    fileSpec.dependencies.add(DependencySpec.part('${renameToOtherMode(fileName, NamedMode.an_apple)}.g.dart'));
    fileSpec.methods.add(MethodSpec.build(
      "_innerValueParser<R>",
      parameters: [
        ParameterSpec.normal("v", type: TypeToken.ofDynamic()),
        ParameterSpec.named("typeR", type: TypeToken.of(Type)),
        ParameterSpec.named("depth", type: TypeToken.ofInt(), defaultValue: 0),
      ],
      returnType: TypeToken.ofDynamic(),
      codeBlock: CodeBlockSpec.empty()..addLine(r"""
  Type type = typeR ?? R;
  if (v == null) return null;
  if (isPrimitive(type)) return translateT<R>(v);
  if (isList(type)) {
    var list = (v as List).map((o) => _innerValueParser(o, typeR: o.runtimeType, depth: depth + 1)).toList();
    switch (type.toString()) {
      case "List<String>":
        return list.map((o) => translateT<String>(o)).toList();
      case "List<int>":
        return list.map((o) => translateT<int>(o)).toList();
      case "List<double>":
        return list.map((o) => translateT<double>(o)).toList();
      case "List<bool>":
        return list.map((o) => translateT<bool>(o)).toList();
      default:
        return list;
    }
  }
      """),
    ));
    return fileSpec;
  }

  String _realClassName(String originClassName) => '_\$${renameTo__AnApple(originClassName)}';

  ClassSpec _buildClassSpec(String className, {bool rootIsObject = true, Iterable<String> keys = const [], TypeToken componentType}) {
    // translate number key
    List<String> mapKeys = keys.toList();
    mapKeys.forEach((key) => mapKeys[mapKeys.indexOf(key)] = _remakePropertyKey(key));
    ClassSpec classSpec = ClassSpec.build(className);
    if (rootIsObject) {
      classSpec.metas.add(MetaSpec.ofConstructor(TypeToken.ofName("JsonSerializable")));
      classSpec.constructors.add(ConstructorSpec.normal(
        classSpec,
        parameters: mapKeys.map((o) => ParameterSpec.named(o, isSelfParameter: true)).toList(),
      ));
      classSpec.constructors.add(ConstructorSpec.namedFactory(
        classSpec,
        'fromJson',
        parameters: [ParameterSpec.normal('json', type: TypeToken.ofDynamic())],
        codeBlock: CodeBlockSpec.empty()
          ..addLine('if (json is Map) return ${_realClassName(className)}FromJson(json);')
          ..addLine('if (json is List) return ${_realClassName(className)}FromJson({\'data\': json});')
          ..addLine('throw \'fromJson parameter must be List or Map, but you give \${json?.runtimeType}\';'),
      ));
      classSpec.methods.add(MethodSpec.build(
        'toJson',
        returnType: TypeToken.ofDynamic(),
        codeBlock: CodeBlockSpec.empty()
          ..addLine('Map<String, dynamic> json = _\$${renameToOtherMode(className, NamedMode.AnApple)}ToJson(this);')
          ..addLine('return _rootIsList ? json[\'data\'] : json;'),
      ));
      classSpec.properties.add(PropertySpec.ofBool('_rootIsList', defaultValue: false));
      classSpec.getters
          .add(GetterSpec.build('isJsonList', type: TypeToken.ofBool(), codeBlock: CodeBlockSpec.empty()..addLine('_rootIsList;')));
    }
    return classSpec;
  }

  PropertySpec _buildPropertySpecOfMap(
      String key, dynamic val, String ownKey, FileSpec fileSpec, String rootClassName, int depth, String selector) {
    PropertySpec propertySpec;
    TypeToken typeToken;
    TypeToken componentTypeToken;
    bool isList = false;
    if (val == null) propertySpec = PropertySpec.ofDynamic(key);
    if (val is int) {
      typeToken = TypeToken.ofInt();
      propertySpec = PropertySpec.ofInt(key);
    } else if (val is double) {
      typeToken = TypeToken.ofDouble();
      propertySpec = PropertySpec.ofDouble(key);
    } else if (val is bool) {
      typeToken = TypeToken.ofBool();
      propertySpec = PropertySpec.ofBool(key);
    } else if (val is String) {
      typeToken = TypeToken.ofString();
      propertySpec = PropertySpec.ofString(key);
    } else if (val is Map) {
      // return a class spec while visit a map in other map
      // get key name like this template: <parent_key><this_key>
      String newKey = _combineToNewKey(ownKey, key);
      // get the element class spec
      ClassSpec innerClassSpec = _iterateJsonEntity(val, newKey, fileSpec, rootClassName, depth + 1, selector);
      // build this object property spec with element class spec
      propertySpec = PropertySpec.of(key, type: TypeToken.ofName(innerClassSpec.className));
    } else if (val is List) {
      isList = true;
      // return component type token while visit a list in other map
      String newKey = _combineToNewKey(ownKey, key);
      // get the element type token
      componentTypeToken = _iterateJsonEntity(val, newKey, fileSpec, rootClassName, depth + 1, selector);
      // build this list property spec with element type token
      propertySpec = PropertySpec.ofListByToken(key, componentType: componentTypeToken);
    }
    typeToken = _extras.containsKey(selector) ? TypeToken.ofName(_extras[selector]) : typeToken;
    if (typeToken != null || isList) {
      String propertyUniqueId = renameTo__AnApple(ownKey) + renameTo__AnApple(propertySpec.name);
      String factoryName = "_parserFunc$propertyUniqueId";
      if (isList) {
        CodeBlockSpec codeBlock;
        String elementParserLine;
        if (componentTypeToken.isPrimitive) {
          elementParserLine = "JsonValueTransformer.parse<${componentTypeToken.typeName}>(o)";
        } else {
          elementParserLine = "_innerValueParser<${componentTypeToken.typeName}>(o)";
        }
        codeBlock = CodeBlockSpec.line("(v as List)?.map<${componentTypeToken.typeName}>((o) => $elementParserLine)?.toList();");

        fileSpec.methods.add(MethodSpec.build(
          factoryName,
          parameters: [ParameterSpec.normal("v", type: TypeToken.ofDynamic())],
          returnType: TypeToken.ofListByToken(componentTypeToken),
          codeBlock: codeBlock,
        ));
      } else {
        fileSpec.methods.add(MethodSpec.build(
          factoryName,
          parameters: [ParameterSpec.normal("v")],
          returnType: typeToken,
          codeBlock: CodeBlockSpec.line("JsonValueTransformer.parse<${typeToken.typeName}>(v);"),
        ));
        propertySpec.type = typeToken;
      }
      _findJsonKeyOrCreate(propertySpec).parameters.add(ParameterSpec.named(
            "fromJson",
            isValue: true,
            value: factoryName,
            valueString: false,
          ));
    }
    return propertySpec;
  }

  MetaSpec _findJsonKeyOrCreate(PropertySpec spec) {
    if (spec.metas.isEmpty || spec.metas.where((o) => o.typeToken == TypeToken.ofName("JsonKey")).isEmpty) {
      spec.metas.add(MetaSpec.ofConstructor(TypeToken.ofName("JsonKey")));
    }
    return spec.metas.firstWhere((o) => o.typeToken == TypeToken.ofName("JsonKey"));
  }

  void _extendValueParserMethod(FileSpec fileSpec, ClassSpec classSpec) {
    MethodSpec parser = fileSpec.methods.firstWhere((o) => o.methodName == "_innerValueParser<R>");
    parser.codeBlock.addLine("if(type == ${classSpec.className}) return ${classSpec.className}.fromJson(v) as R;");
  }
}

void generateJsonBeanFile(String source, File outputFile, {String rootClassName, bool runBuildRunner = false}) async {
  if (rootClassName == null) rootClassName = XFile.fromFile(outputFile).fileName(withExtension: false);
  var result = _sourceResolver(source);
  Map<String, String> extras = result[0];
  source = result[1];
  String content = _Xson()._makeJsonBean(XFile.fromFile(outputFile).fileName(withExtension: false), rootClassName, source, extras: extras);
  outputFile.writeAsStringSync(content);
  if (runBuildRunner) {
    ProcessResult result = await executeBuildRunner();
    print(result.stdout);
  }
}

String readJsonIgnoreComments(String json) => json.split('\n').where((o) => !o.trimLeft().startsWith('//')).join('\n');

List Function(String) _sourceResolver = (source) {
  var lines = source.split('\n');
  var jsonSource = lines.where((line) => !line.trimLeft().startsWith(RegExp('//@?'))).join('\n');
  var extras = <String, String>{};
  extras.addEntries(lines.where((line) => line.trimLeft().startsWith('//@')).map((line) => line.substring(3)).map((line) {
    var splits = line.split('=');
    return MapEntry(splits[0], splits[1]);
  }).toList());
  return [extras, jsonSource];
};

Future<ProcessResult> executeBuildRunner() async {
  if (Platform.isWindows) {
    return await Process.run(
      'cmd.exe',
      ['/c', 'flutter', 'packages', 'pub', 'run', 'build_runner', 'build'],
      stdoutEncoding: utf8,
      stderrEncoding: utf8,
    );
  } else if (Platform.isMacOS) {
    return await Process.run(
      '/bin/sh',
      ['flutter', 'packages', 'pub', 'run', 'build_runner', 'build'],
      stdoutEncoding: utf8,
      stderrEncoding: utf8,
    );
  }
  return null;
}
