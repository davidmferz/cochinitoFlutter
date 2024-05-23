class ValidationErrorModel {
  String? message;

  ValidationErrorModel({this.message});

  static ValidationErrorModel fromJson(Map<String, dynamic> json) {
    final errorMessages = <ValidationErrorModel>[];
    json.forEach((key, value) {
      if (key == "errors") {
        Map<String, dynamic> map = Map<String, dynamic>.from(json[key]);
        map.forEach((mapKey, value) {
          errorMessages.add(ValidationErrorModel(message: map[mapKey][0]));
        });
      }
    });
    return errorMessages.first;
  }
}