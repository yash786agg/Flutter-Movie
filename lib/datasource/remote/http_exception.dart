class HTTPException implements Exception {
  HTTPException({
    this.code,
    this.message,
  });

  final int code;
  final String message;

  @override
  String toString() {
    return 'HTTPException{code: $code, message: $message}';
  }
}
