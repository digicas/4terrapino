// ignore: avoid_web_libraries_in_flutter
import 'dart:js';

class ParseError {
  ParseError({required this.code, required this.message});

  final int code;
  final String message;

  void onError() {
    context.callMethod('onError', [code, message]);
  }
}
