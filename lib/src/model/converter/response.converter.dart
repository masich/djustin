import 'package:djustin/src/model/common/locale.dart';
import 'package:djustin/src/model/converter/json_converter.dart';
import 'package:djustin/src/model/response.dart';

class ResponseConverter<Result, ResultConverter extends JsonConverter<Result>>
    extends JsonConverter<Response<Result>> {
  ResponseConverter(this._resultConverter);

  final JsonConverter<Result> _resultConverter;
  ResponseMassageConverter _messageConverter;

  List<Result> _parseResults(List<dynamic> json) {
    return json == null
        ? null
        : json
            .map((resultJson) => _resultConverter.fromJson(resultJson))
            ?.toList();
  }

  @override
  Response<Result> fromNotBlankJson(Map<String, dynamic> json) {
    _messageConverter ??= ResponseMassageConverter();
    return Response(json['status'], _messageConverter.fromJson(json['msg']),
        _parseResults(json['result']));
  }
}

class ResponseMassageConverter extends JsonConverter<ResponseMessage> {
  @override
  ResponseMessage fromNotBlankJson(Map<String, dynamic> json) {
    return ResponseMessage(json['code'], Locale.parseLocalizedText('', json));
  }
}
