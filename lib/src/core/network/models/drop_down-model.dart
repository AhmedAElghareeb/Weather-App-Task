class DropDownModel<T> {
  final T value;
  final String label;

  DropDownModel({
    required this.value,
    required this.label,
  });

  factory DropDownModel.fromJson(Map<String, dynamic> json) {
    return DropDownModel(
      value: json['value'],
      label: json['label'],
    );
  }
}
