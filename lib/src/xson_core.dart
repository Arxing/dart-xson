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

  Map<String, dynamic> _remakePropertyKey(String oldKey) {
    String newKey;
    if (_DART_KEYWORDS.contains(oldKey) || oldKey.startsWith(RegExp('[0-9]'))) {
      newKey = '\$$oldKey';
    } else {
      newKey = oldKey;
    }
    newKey = newKey.replaceAll(RegExp('[^0-9a-zA-Z_\$]+'), '_');
    newKey = renameTo__anApple(newKey);
    MetaSpec metaSpec;
    if (newKey != oldKey) metaSpec = MetaSpec.of('JsonKey(name: \'$oldKey\')');
    return {'key': newKey, 'meta': metaSpec};
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
      // foreach elements in map entity
      for (var entry in map.entries) {
        String key = entry.key;
        dynamic val = entry.value;
        Map<String, dynamic> product = _remakePropertyKey(key);
        PropertySpec propertySpec = _buildPropertySpecOfMap(product['key'], val, ownKey, fileSpec, rootClassName, depth, "$selector.$key");
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
      } else {
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

  String _realClassName(String originClassName) => '_\$${renameTo__AnApple(originClassName)}';

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
      ClassSpec innerClassSpec = _iterateJsonEntity(val, newKey, fileSpec, rootClassName, depth + 1, selector);
      // build this object property spec with element class spec
      propertySpec = PropertySpec.of(key, type: TypeToken.ofName(innerClassSpec.className));
    } else if (val is List) {
      // return component type token while visit a list in other map
      String newKey = _combineToNewKey(ownKey, key);
      // get the element type token
      TypeToken componentType = _iterateJsonEntity(val, newKey, fileSpec, rootClassName, depth + 1, selector);
      // build this list property spec with element type token
      propertySpec = PropertySpec.ofListByToken(key, componentType: componentType);
    }
    if(_extras.containsKey(selector)){



    }


    propertySpec.doc = DocSpec.text(selector);
    return propertySpec;
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

List Function(String) _sourceResolver = (source) {
  var lines = source.split('\n');
  var jsonSource = lines.where((line) => !line.trimLeft().startsWith(RegExp('//@?'))).join('\n');
  var extras = {};
  extras.addEntries(lines.where((line) => line.trimLeft().startsWith('//@')).map((line) => line.substring(0, 2)).map((line) {
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
