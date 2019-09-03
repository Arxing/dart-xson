import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart' as crypt;
import 'package:convert/convert.dart';
import 'package:xson/xson.dart';
import 'package:dartpoet/dartpoet.dart';
import 'package:named_mode/named_mode.dart';
import 'package:xfile/xfile.dart';

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

  dynamic _iterateJsonEntity(dynamic entity, String ownKey, FileSpec fileSpec, String rootClassName) {
    rootClassName = renameToOtherMode(rootClassName, NamedMode.AnApple);
    bool isRoot = (ownKey == null);
    // concat class name with bean at tail
    String className = '${ownKey ?? rootClassName}Bean';
    // rename class name
    className = renameToOtherMode(className, NamedMode.AnApple);
    print('ownKey=$ownKey, rootClassName=$rootClassName, className=$className');

    if (entity is Map) {
      // return a class spec while visit at map
      Map<String, dynamic> map = entity;

      // build class spec
      ClassSpec classSpec = _buildClassSpec(className, isRootObject: true, keys: map.keys).single;
      // foreach elements in map entity
      for (var entry in map.entries) {
        String key = entry.key;
        dynamic val = entry.value;
        bool isNumberKey = key.startsWith(RegExp('[0-9]'));
        PropertySpec propertySpec;

        // build property spec in this class spec
        if (isNumberKey) {
          // handle number keys
          String $key = '\$$key';
          propertySpec = _buildPropertySpecOfMap($key, val, ownKey, fileSpec, rootClassName);
          propertySpec.metas.add(MetaSpec.of('JsonKey(name: \'$key\')'));
        } else {
          propertySpec = _buildPropertySpecOfMap(key, val, ownKey, fileSpec, rootClassName);
        }

        // link property spec and class spec
        classSpec.properties.add(propertySpec);
      }
      // insert this class spec to file spec
      fileSpec.classes.add(classSpec);
      return classSpec;
    }

    if (entity is List) {
      // return a type token (first component type) while visit at list
      List<dynamic> list = entity;
      TypeToken type = _generateListTypeToken(ownKey, list, fileSpec, rootClassName);
      return type;

//      dynamic firstComponent = list.isEmpty ? null : list[0];
//      if (isRoot) {
//        List<ClassSpec> classSpecs = _buildClassSpec(className, isRootObject: false, firstComponent: firstComponent).toList();
//        fileSpec.classes.addAll(classSpecs);
//      } else {}
//
//      TypeToken componentType = _buildComponentTypeOfList(firstComponent, ownKey, fileSpec, rootClassName);
//      return componentType;
    }
  }

  TypeToken _generateListTypeToken(String ownKey, List<dynamic> list, FileSpec fileSpec, String fileName) {
    if (list == null || list.isEmpty) return TypeToken.ofDynamic();
    List<TypeToken> elementTypes = [];
    Map<String, JsonInfo> cache = {};
    for (var element in list) {
      if (element == null) elementTypes.add(TypeToken.ofDynamic());
      if (isPrimitive(element?.runtimeType))
        elementTypes.add(TypeToken.parse(element));
      else {
        JsonInfo jsonInfo = JsonInfo.parse(element);
        String md5 = jsonInfo.md5;
        if (cache.containsKey(md5)) continue;
        cache[jsonInfo.md5] = jsonInfo;
        int index = list.indexOf(element);
        String newKey = '${ownKey ?? ''}\$${index}List';
        TypeToken typeToken = TypeToken.ofName(jsonInfo.type);
        _iterateJsonEntity(element, newKey, fileSpec, fileName);
        elementTypes.add(typeToken);
      }
    }
    if (elementTypes.toSet().toList().length == 1)
      return elementTypes[0];
    else
      return TypeToken.ofDynamic();
  }

  FileSpec _buildFileSpec(String fileName) {
    FileSpec fileSpec = FileSpec.build();

    // import json convert
    fileSpec.dependencies.add(DependencySpec.import('dart:convert'));
    fileSpec.dependencies.add(DependencySpec.import('package:json_annotation/json_annotation.dart'));
    fileSpec.dependencies.add(DependencySpec.part('${renameToOtherMode(fileName, NamedMode.an_apple)}.g.dart'));
    return fileSpec;
  }

  Iterable<ClassSpec> _buildClassSpec(String className,
      {bool isRootObject = true, Iterable<String> keys = const [], dynamic firstComponent}) sync* {
    // translate number key
    List<String> mapKeys = keys.toList();
    mapKeys.forEach((key) {
      if (key.startsWith(RegExp('[0-9]'))) mapKeys[mapKeys.indexOf(key)] = '\$$key';
    });

    ClassSpec classSpec = ClassSpec.build(className);
    if (isRootObject) {
      classSpec.metas.add(MetaSpec.of('JsonSerializable()'));
      classSpec.constructors.add(ConstructorSpec.normal(
        classSpec,
        parameters: mapKeys.map((o) => ParameterSpec.named(o, isSelfParameter: true)).toList(),
      ));
      classSpec.constructors.add(ConstructorSpec.namedFactory(
        classSpec,
        'fromJson',
        parameters: [
          ParameterSpec.normal('json', type: TypeToken.ofMap<String, dynamic>()),
        ],
        codeBlock: CodeBlockSpec.line('_\$${renameToOtherMode(className, NamedMode.AnApple)}FromJson(json);'),
      ));
      classSpec.methods.add(MethodSpec.build(
        'toJson',
        returnType: TypeToken.ofMap<String, dynamic>(),
        codeBlock: CodeBlockSpec.line('_\$${renameToOtherMode(className, NamedMode.AnApple)}ToJson(this);'),
      ));
    } else {
      classSpec.properties.add(PropertySpec.of(
        'data',
        type: TypeToken.ofListByToken(TypeToken.parse(firstComponent)),
      ));
      classSpec.constructors.add(ConstructorSpec.namedFactory(
        classSpec,
        'fromJson',
        parameters: [
          ParameterSpec.normal('json', type: TypeToken.ofMap<String, dynamic>()),
        ],
        codeBlock: CodeBlockSpec.line('int a = 0;'),
      ));
      classSpec.methods.add(MethodSpec.build(
        'toJson',
        returnType: TypeToken.ofMap<String, dynamic>(),
        codeBlock: CodeBlockSpec.line(''),
      ));
      if (firstComponent != null && !isPrimitive(firstComponent?.runtimeType)) {
        Map<String, dynamic> map = firstComponent;
        ClassSpec dataClassSpec = _buildClassSpec('DataBean', isRootObject: true, keys: map.keys).single;
        yield dataClassSpec;
      }
    }
    yield classSpec;
  }

  PropertySpec _buildPropertySpecOfMap(String key, dynamic val, String ownKey, FileSpec fileSpec, String rootClassName) {
    PropertySpec propertySpec;
    if (val == null) propertySpec = PropertySpec.ofDynamic(key);
    if (val is int)
      propertySpec = PropertySpec.ofInt(key);
    else if (val is double)
      propertySpec = PropertySpec.ofDouble(key);
    else if (val is bool)
      propertySpec = PropertySpec.ofBool(key);
    else if (val is String)
      propertySpec = PropertySpec.ofString(key);
    else if (val is Map) {
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

  TypeToken _buildComponentTypeOfList(dynamic firstComponent, String ownKey, FileSpec fileSpec, String rootClassName) {
    TypeToken componentType;
    if (firstComponent == null) componentType = TypeToken.ofDynamic();
    if (firstComponent is int)
      componentType = TypeToken.ofInt();
    else if (firstComponent is double)
      componentType = TypeToken.ofDouble();
    else if (firstComponent is bool)
      componentType = TypeToken.ofBool();
    else if (firstComponent is String)
      componentType = TypeToken.ofString();
    else if (firstComponent is Map) {
      ClassSpec componentClassSpec = _iterateJsonEntity(firstComponent, ownKey, fileSpec, rootClassName);
      componentType = TypeToken.ofName(componentClassSpec.className);
    } else if (firstComponent is List) {
      TypeToken innerComponentType = _iterateJsonEntity(fileSpec, ownKey, fileSpec, rootClassName);
      componentType = TypeToken.ofListByToken(innerComponentType);
    }
    return componentType;
  }
}

void generateJsonBeanFile(String source, File outputFile) {
  String content = _Xson()._makeJsonBean(XFile.fromFile(outputFile).fileName(withExtension: false), 'Root', source);
  outputFile.writeAsStringSync(content);
  executeBuildRunner().then((result)=>print(result.stdout));
}

//void generateJsonBeanInDirectory(String inputDirectory, String outputDirectory, {String Function(String) sourceReFormatter}) {
//  XFile assetsJsonDir = XFile.fromPath(inputDirectory);
//  XFile outputDir = XFile.fromPath(outputDirectory);
//  assetsJsonDir.directory.listSync().where((file) => XFile.fromPath(file.path).extension() == 'json').forEach((file) {
//    XFile xFile = XFile.fromPath(file.path);
//    String fileName = xFile.fileName(withExtension: false);
//    String jsonSource = xFile.file.readAsStringSync();
//    if (sourceReFormatter != null) jsonSource = sourceReFormatter(jsonSource);
//    print(jsonSource);
//    String generatedFileName = renameToOtherMode(fileName, NamedMode.an_apple) + '_bean.dart';
//    File outputFile = outputDir.append(generatedFileName).file;
//    Xson().makeJsonBeanToFile(fileName, jsonSource, outputFile);
//    print('generated file at ${outputFile.path}');
//  });
//  executeBuildRunner().then((result) => print(result.stdout), onError: (e) => print('occured error: $e'));
//}

Future<ProcessResult> executeBuildRunner() async {
  if (Platform.isWindows) {
    return await Process.run(
      'cmd.exe',
      ['/c', 'flutter', 'packages', 'pub', 'run', 'build_runner', 'build'],
      stdoutEncoding: utf8,
      stderrEncoding: utf8,
    );
  } else if (Platform.isIOS) {
    return await Process.run(
      '/bin/sh',
      ['-c', 'flutter', 'packages', 'pub', 'run', 'build_runner', 'build'],
      stdoutEncoding: utf8,
      stderrEncoding: utf8,
    );
  }
  return null;
}
