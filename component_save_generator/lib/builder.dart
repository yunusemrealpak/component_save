import 'package:build/build.dart';
import 'package:component_save_generator/generator/component_config_generator.dart';
import 'package:component_save_generator/generator/component_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder componentBuilder(BuilderOptions options) =>
    LibraryBuilder(ComponentConfigGenerator(),
        generatedExtension: '.component.dart');

Builder componentBuilderJson(BuilderOptions options) {
  return LibraryBuilder(
    ComponentGenerator(),
    formatOutput: (generated) => generated.replaceAll(RegExp(r'//.*|\s'), ''),
    generatedExtension: '.component.json',
  );
}
