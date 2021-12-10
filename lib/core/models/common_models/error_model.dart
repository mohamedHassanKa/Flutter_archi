class ErrorModel {
  ErrorModel({
    this.errorCode,
    this.statusCode,
    this.message,
  });

  ErrorModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    message = json['message'];
  }

  String? errorCode;
  int? statusCode;
  String? message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['message'] = message;
    return data;
  }

  String? getErrorDescription() {
    return message;
  }

  String? getErrorCodeString() {
    return errorCode;
  }
}
