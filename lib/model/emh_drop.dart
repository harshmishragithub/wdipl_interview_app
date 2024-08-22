class EmhQuestion {
  final String status;
  final int statusCode;
  final String message;
  final List data;
  EmhQuestion(
      {required this.status,
      required this.statusCode,
      required this.message,
      required this.data});
}
