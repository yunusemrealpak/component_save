import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:component_save_annotation/component_save_annotation.dart';
import 'package:component_save_generator/models/component_config.dart';
import 'package:source_gen/source_gen.dart';

class ComponentGenerator extends GeneratorForAnnotation<Component> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Generator cannot target `${element.displayName}`.',
      );
    }

    final obj = annotation.objectValue;

    final description = obj.getField('description')!.toStringValue()!;
    var name = obj.getField('name')?.toStringValue();

    name ??= element.name;

    final inputId = buildStep.inputId;
    final fileContent = await buildStep.readAsString(inputId);

    final widgetCode = _extractWidgetCode(fileContent, name);
    final code = widgetCode.replaceAll(' ', "__space__");

    final config =
        ComponentConfig(name: name, description: description, code: code)
            .toJson();

    return json.encode(config);
  }

  String _extractWidgetCode(String fileContent, String className) {
    // Sınıfın başlangıcını bulalım
    final widgetStart = fileContent.indexOf('class $className');
    if (widgetStart == -1) {
      return ''; // Sınıf bulunamadıysa boş string döneriz
    }

    // Sınıfın sonunu bulmak için, tüm "{" ve "}" lerin eşleşmesini takip ederek sınıfın sonunu bulmamız gerek
    int openBraces = 0;
    int closeBraces = 0;
    int classEnd = widgetStart;

    for (int i = widgetStart; i < fileContent.length; i++) {
      if (fileContent[i] == '{') {
        openBraces++;
      } else if (fileContent[i] == '}') {
        closeBraces++;
      }

      // Eğer açık ve kapalı süslü parantezler eşitlendiğinde bu sınıfın sonudur
      if (openBraces > 0 && openBraces == closeBraces) {
        classEnd = i;
        break;
      }
    }

    // Boşlukları ve satır sonlarını koruyarak substring alıyoruz
    final widgetCode = fileContent.substring(widgetStart, classEnd + 1);

    // Trim veya herhangi bir boşluk silme işlemi yapılmıyor
    return widgetCode;
  }
}
