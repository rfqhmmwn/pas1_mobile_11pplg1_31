class LogModel {
  bool status;
  String message;

  LogModel({
    required this.status,
    required this.message,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      status: json['status'] as bool,
      message: json['message'] as String,
    );
  }
}