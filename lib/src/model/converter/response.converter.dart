import 'package:djustin/src/model/common/json_converter.dart';
import 'package:djustin/src/model/common/activator.dart';
import 'package:djustin/src/model/common/locale.dart';

import 'package:djustin/src/model/response.dart';

class ResponseConverter<ResultType,
        ResultConverter extends JsonConverter<ResultType>>
    implements JsonConverter<Response<ResultType>> {
  ResultConverter resultConverter;

  List<ResultType> _parseResults(List<dynamic> json) {
    var resultsJson = json?.map((e) => e as Map<String, dynamic>);
    List<ResultType> results;
    if (resultsJson != null) {
      resultConverter ??= Activator.createInstance(ResultConverter);
      results = resultsJson
          .map((resultJson) => resultConverter.fromJson(resultJson))
          ?.toList();
    }
    return results;
  }

  @override
  Response<ResultType> fromJson(Map<String, dynamic> json) {
    return Response<ResultType>(
        json['status'],
        ResponseMassageConverter().fromJson(json['msg']),
        _parseResults(json['result'] as List<dynamic>));
  }

  @override
  Map<String, dynamic> toJson(Response<ResultType> value) {
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
