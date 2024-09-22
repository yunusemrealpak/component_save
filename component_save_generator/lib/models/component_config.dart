class ComponentConfig {
  final String? name;
  final String description;
  final String code;

  ComponentConfig({
    this.name,
    required this.description,
    required this.code,
  });

  factory ComponentConfig.fromJson(Map<String, dynamic> json) {
    return ComponentConfig(
      name: json['name'],
      description: json['description'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'code': code,
    };
  }
}
