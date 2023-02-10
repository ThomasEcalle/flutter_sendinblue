class SendinblueApiException implements Exception {
  final int statusCode;
  final String body;

  SendinblueApiException(this.statusCode, this.body);

  @override
  String toString() {
    return 'SendinblueApiException{statusCode: $statusCode, body: $body}';
  }
}
