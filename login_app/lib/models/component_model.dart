class ComponentModel {
  final String text;
  final double value;
  final bool isSelected;

  ComponentModel({
    required this.text,
    required this.value,
    this.isSelected = false,
  });

  ComponentModel copyWith({
    String? text,
    double? value,
    bool? isSelected,
  }) {
    return ComponentModel(
      text: text ?? this.text,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
