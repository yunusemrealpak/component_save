import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:component_save_annotation/component_save_annotation.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

import '../models/component_config.dart';
import '../request/save_request.dart';

class ComponentConfigGenerator
    extends GeneratorForAnnotation<ComponentSaverInit> {
  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final injectableConfigFiles = Glob("lib/**.component.json");

    List<ComponentConfig> configs = [];

    await for (final id in buildStep.findAssets(injectableConfigFiles)) {
      final content = await buildStep.readAsString(id);
      final json = jsonDecode(content);
      final config = ComponentConfig.fromJson(json);

      configs.add(config);

      SaveRequest.send(config);
    }

    return """
abstract class \$ComponentSaver {}

/*
${configs.map((e) => e.name).join('\n')}

are generated.
*/
""";
  }
}
