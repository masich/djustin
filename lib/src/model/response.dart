import 'package:djustin/src/model/common/locale.dart';

class Response<ResultType> {
  static const int statusOk = 1;

  final int status;

  // jsonName: 'msg'
  final ResponseMessage message;

  // jsonName: 'result'
  final List<ResultType> results;

  Response(this.status, this.message, this.results);

  @override
  String toString() {
    return 'Response { '
        'status: $status, '
        'message: $message, '
        'results: $results '
        '}';
  }
}

class ResponseMessage {
  final int code;

  // jsonName: 'ru', 'ua', 'en'
  final Map<Language, String> text;

  ResponseMessage(this.code, this.text);

  @override
  String toString() {
    return 'ResponseMessage { '
        'code: $code, '
        'text: $text '
        '}';
  }
}
