import 'package:component_save_annotation/component_save_annotation.dart';
import 'package:flutter/material.dart';

@Component(description: 'This is a custom text')
class CustomText extends StatelessWidget {
  final String text;
  const CustomText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
