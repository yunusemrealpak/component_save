import 'package:component_save_annotation/component_save_annotation.dart';
import 'package:flutter/material.dart';

@Component(description: 'This is a custom button')
class CustomButton extends StatelessWidget {
  final String label;
  const CustomButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label);
  }
}
