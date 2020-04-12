import 'package:djustin/src/model/common/locale.dart';
import 'package:djustin/src/model/converter/json_converter.dart';
import 'package:djustin/src/model/response.dart';

class ResponseConverter<Result, ResultConverter extends JsonConverter<Result>>
    extends JsonConverter<Response<Result>> {
  ResponseConverter(JsonConverter<Result> resultConverter)
      : _resultConverter = resultConverter;

  final ResultConverter _resultConverter;
  ResponseMassageConverter _messageConverter;

  List<Result> _parseResults(List<dynamic> json) {
    var resultsJson = json?.map((e) => e as Map<String, dynamic>);
    List<Result> results;
    if (resultsJson != null) {
      results = resultsJson
          .map((resultJson) => _resultConverter.fromJson(resultJson))
          ?.toList();
    }
    return results;
  }

  @override
  Response<Result> fromJson(Map<String, dynamic> json) {
    Response response;
    if (json != null) {
      _messageConverter ??= ResponseMassageConverter();
      response = Response<Result>(
          json['status'],
          _messageConverter.fromJson(json['msg']),
          _parseResults(json['result'] as List<dynamic>));
    }
    return response;
  }

  @override
  Map<String, dynamic> toJson(Response<Result> value) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class ResponseMassageConverter extends JsonConverter<ResponseMessage> {
  @override
  ResponseMessage fromJson(Map<String, dynamic> json) {
    ResponseMessage message;
    if (json != null) {
      message = ResponseMessage(json['code'], {
        Language.UA: json['ua'],
        Language.EN: json['en'],
        Language.RU: json['ru']
      });
    }
    return message;
  }

  @override
  Map<String, dynamic> toJson(ResponseMessage value) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
