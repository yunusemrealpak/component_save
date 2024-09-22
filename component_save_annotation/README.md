# Flutter Component Generator

A Flutter code generator that scans the project for widgets annotated with `@Component` and automatically sends their name, description, and source code to a .NET Web API endpoint for further processing and documentation.

## Features

- Automatically scans the project for widgets annotated with `@Component`.
- Extracts the name, description, and source code of the widget.
- Sends the extracted data to a configurable .NET Web API endpoint.
- Simplifies the process of documenting and managing Flutter widgets.
- Ideal for projects where tracking and visualizing widgets is important.

## Installation

To use this generator, you need to include the following dependencies in your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.0.10

dev_dependencies:
  build_runner: latest_version
  source_gen: latest_version
```

## Usage
1. Annotate your widget classes with @Component.
2. Run the code generator with the following command:

```bash
flutter pub run build_runner build
```

## Example

```dart
import 'package:component_save_annotation/component_save_annotation.dart';
import 'package:flutter/material.dart';

@Component(name: 'CustomButton', description: 'This is a custom button')
class CustomButton extends StatelessWidget {
  final String label;
  const CustomButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label);
  }
}
```

## Contributing
Feel free to open issues or submit pull requests for improvements and bug fixes.

## License
This project is licensed under the MIT License.


