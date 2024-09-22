import 'dart:convert';

import 'package:component_save_generator/models/component_config.dart';
import 'package:dio/dio.dart';

class SaveRequest {
  static Future<void> send(ComponentConfig component) async {
    Dio dio = Dio();

    final requestBody = {
      'name': component.name,
      'description': component.description,
      'code': component
          .code, // Kodun olduğu gibi (boşluklar korunmuş şekilde) gönderilmesi sağlanır
    };

    try {
      final response = await dio.post(
        'https://localhost:44366/api/ComponentSaver/SaveComponent',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Component başarıyla kaydedildi');
      } else {
        print('Component kaydedilemedi: ${response.statusCode}');
      }
    } catch (e) {
      print('API isteği sırasında bir hata oluştu: $e');
    }
  }
}
