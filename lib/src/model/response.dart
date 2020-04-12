import 'package:djustin/src/model/common/locale.dart';

class Response<ResultType> {
  final int status;

  // jsonName: 'msg'
  final ResponseMessage message;

  // jsonName: 'result'
  final List<ResultType> results;

  Response(this.status, this.message, this.results);
}

class ResponseMessage {
  final int code;

  // jsonName: 'ru', 'ua', 'en'
  final Map<Language, String> text;

  ResponseMessage(this.code, this.text);
}
