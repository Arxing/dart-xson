import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart' as crypt;
import 'package:convert/convert.dart';
import 'package:xson/xson.dart';
import 'package:dartpoet/dartpoet.dart';
import 'package:named_mode/named_mode.dart';
import 'package:xfile/xfile.dart';

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
  String _makeJsonBean(String fileName, String rootClassName, String jsonSource) {
    dynamic json;
    try {
      // decode string to json
      json = jsonDecode(jsonSource);
    } catch (e) {
      print('json decode error: $e');
      return '';
    }

    // create file spec
    FileSpec fileSpec = _buildFileSpec(fileName);
    // iterate json all nodes and build file spec
    _iterateJsonEntity(json, null, fileSpec, rootClassName);

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

  Map<String, dynamic> _remakePropertyKey(String oldKey) {
    String newKey;
    if (_DART_KEYWORDS.contains(oldKey) || oldKey.startsWith(RegExp('[0-9]'))) {
      newKey = '\$$oldKey';
    } else {
      newKey = oldKey;
    }
    newKey = renameTo__anApple(newKey);
    MetaSpec metaSpec;
    if (newKey != oldKey) metaSpec = MetaSpec.of('JsonKey(name: \'$oldKey\')');
    return {'key': newKey, 'meta': metaSpec};
  }

  dynamic _iterateJsonEntity(dynamic entity, String ownKey, FileSpec fileSpec, String rootClassName) {
    rootClassName = renameToOtherMode(rootClassName, NamedMode.AnApple);
    bool isRoot = (ownKey == null);

    String headName = renameTo__AnApple(ownKey ?? rootClassName);
    // concat class name with bean at tail
    String className = '${headName}Bean';
    // rename class name
    className = renameToOtherMode(className, NamedMode.AnApple);
//    print('ownKey=$ownKey, rootClassName=$rootClassName, className=$className');

    if (entity is Map) {
      // return a class spec while visit at map
      Map<String, dynamic> map = entity;

      // build class spec
      ClassSpec classSpec = _buildClassSpec(className, rootIsObject: true, keys: map.keys);
      // foreach elements in map entity
      for (var entry in map.entries) {
        String key = entry.key;
        dynamic val = entry.value;
        Map<String, dynamic> product = _remakePropertyKey(key);
        PropertySpec propertySpec = _buildPropertySpecOfMap(product['key'], val, ownKey, fileSpec, rootClassName);
        MetaSpec metaSpec = product['meta'];
        if (metaSpec != null) propertySpec.metas.add(metaSpec);
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
        return _iterateJsonEntity(wrapped, ownKey, fileSpec, rootClassName);
      } else {
        // return a type token (first component type) while visit at list
        List<dynamic> list = entity;
        TypeToken type = _generateListTypeToken(ownKey, list, fileSpec, rootClassName);
        return type;
      }
    }
  }

  TypeToken _generateListTypeToken(String ownKey, List<dynamic> list, FileSpec fileSpec, String fileName) {
    if (list == null || list.isEmpty) return TypeToken.ofDynamic();
    List<TypeToken> elementTypes = [];
    Map<String, JsonInfo> cache = {};
    for (var element in list) {
      if (element == null) elementTypes.add(TypeToken.ofDynamic());
      if (isPrimitive(element?.runtimeType)) {
        elementTypes.add(TypeToken.parse(element));
      } else {
        JsonInfo jsonInfo = JsonInfo.parse(element);
        String md5 = jsonInfo.md5;
        if (cache.containsKey(md5)) continue;
        cache[jsonInfo.md5] = jsonInfo;
        int index = list.indexOf(element);
        String newKey = '${ownKey ?? ''}\$${index}List';
//        TypeToken typeToken = TypeToken.ofName(jsonInfo.type+'99');
        TypeToken typeToken;
        dynamic result = _iterateJsonEntity(element, newKey, fileSpec, fileName);
        if (result is ClassSpec) {
          typeToken = TypeToken.ofName(result.className);
        } else {
          typeToken = result;
        }
        elementTypes.add(typeToken);
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
    fileSpec.dependencies.add(DependencySpec.part('${renameToOtherMode(fileName, NamedMode.an_apple)}.g.dart'));
    return fileSpec;
  }

  ClassSpec _buildClassSpec(String className, {bool rootIsObject = true, Iterable<String> keys = const [], TypeToken componentType}) {
    // translate number key
    List<String> mapKeys = keys.toList();
    mapKeys.forEach((key) => mapKeys[mapKeys.indexOf(key)] = _remakePropertyKey(key)['key']);
    ClassSpec classSpec = ClassSpec.build(className);
    if (rootIsObject) {
      classSpec.metas.add(MetaSpec.of('JsonSerializable()'));
      classSpec.constructors.add(ConstructorSpec.normal(
        classSpec,
        parameters: mapKeys.map((o) => ParameterSpec.named(o, isSelfParameter: true)).toList(),
      ));
      classSpec.constructors.add(ConstructorSpec.namedFactory(
        classSpec,
        'fromJson',
        parameters: [ParameterSpec.normal('json', type: TypeToken.ofMap<String, dynamic>())],
        codeBlock: CodeBlockSpec.empty()..addLine('_\$${renameToOtherMode(className, NamedMode.AnApple)}FromJson(json);'),
      ));
      classSpec.constructors.add(ConstructorSpec.namedFactory(
        classSpec,
        'fromJsonString',
        parameters: [
          ParameterSpec.normal('jsonSource', type: TypeToken.ofString()),
        ],
        codeBlock: CodeBlockSpec.empty()
          ..addLine('dynamic json = jsonDecode(jsonSource);')
          ..addLine('bool rootIsList = json is List;')
          ..addLine('if (rootIsList) json = {\'data\': json};')
          ..addLine('var instance = $className.fromJson(json);')
          ..addLine('instance._rootIsList = rootIsList;')
          ..addLine('return instance;'),
      ));
      classSpec.methods.add(MethodSpec.build(
        'toJsonString',
        returnType: TypeToken.ofString(),
        codeBlock: CodeBlockSpec.empty()
          ..addLine('Map<String, dynamic> json = _\$${renameToOtherMode(className, NamedMode.AnApple)}ToJson(this);')
          ..addLine('dynamic out = _rootIsList ? json[\'data\'] : json;')
          ..addLine('return jsonEncode(out);'),
      ));
      classSpec.properties.add(PropertySpec.ofBool('_rootIsList', defaultValue: false));
    } else {
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      classSpec.properties.add(PropertySpec.of(
        'data',
        type: TypeToken.ofListByToken(componentType),
      ));
      classSpec.methods.add(MethodSpec.build(
        'fromJson',
        isStatic: true,
        parameters: [
          ParameterSpec.normal('json', type: TypeToken.ofString()),
        ],
        codeBlock: CodeBlockSpec.empty()
          ..addLine('$className instance = $className();')
          ..addLine('instance.data = jsonDecode(json);')
          ..addLine('return instance;'),
      ));
      classSpec.methods.add(MethodSpec.build(
        'toJson',
        returnType: TypeToken.ofString(),
        codeBlock: CodeBlockSpec.empty()..addLine('int a=0;'),
      ));
    }
    return classSpec;
  }

  PropertySpec _buildPropertySpecOfMap(String key, dynamic val, String ownKey, FileSpec fileSpec, String rootClassName) {
    PropertySpec propertySpec;
    if (val == null) propertySpec = PropertySpec.ofDynamic(key);
    if (val is int) {
      propertySpec = PropertySpec.ofInt(key);
    } else if (val is double) {
      propertySpec = PropertySpec.ofDouble(key);
    } else if (val is bool) {
      propertySpec = PropertySpec.ofBool(key);
    } else if (val is String) {
      propertySpec = PropertySpec.ofString(key);
    } else if (val is Map) {
      // return a class spec while visit a map in other map
      // get key name like this template: <parent_key><this_key>
      String newKey = _combineToNewKey(ownKey, key);
      // get the element class spec
      ClassSpec innerClassSpec = _iterateJsonEntity(val, newKey, fileSpec, rootClassName);
      // build this object property spec with element class spec
      propertySpec = PropertySpec.of(key, type: TypeToken.ofName(innerClassSpec.className));
    } else if (val is List) {
      // return component type token while visit a list in other map
      String newKey = _combineToNewKey(ownKey, key);
      // get the element type token
      TypeToken componentType = _iterateJsonEntity(val, newKey, fileSpec, rootClassName);
      // build this list property spec with element type token
      propertySpec = PropertySpec.ofListByToken(key, componentType: componentType);
    }
    return propertySpec;
  }
}

void generateJsonBeanFile(String source, File outputFile, {String rootClassName, bool runBuildRunner = false}) async {
  if (rootClassName == null) rootClassName = XFile.fromFile(outputFile).fileName(withExtension: false);
  String content = _Xson()._makeJsonBean(XFile.fromFile(outputFile).fileName(withExtension: false), rootClassName, source);
  outputFile.writeAsStringSync(content);
  if (runBuildRunner) {
    ProcessResult result = await executeBuildRunner();
    print(result.stdout);
  }
}

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
