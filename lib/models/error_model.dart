class ErrorModel {
  final String message;
  final String? code;

  ErrorModel({required this.message, this.code});

  @override
  String toString() {
    return 'ErrorModel(message: $message, code: $code)';
  }
}
