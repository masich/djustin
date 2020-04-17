import 'dart:io';

import 'package:djustin/converters.dart';
import 'package:djustin/src/model/converter/response.converter.dart';
import 'package:djustin/src/model/response.dart';
import 'package:http/http.dart' as http;

typedef OnHttpErrorCallback = void Function(int statusCode, String endpoint);

class Service {
  static const int httpStatusCodeOk = 200;

  final String _endpointBase;
  final http.Client _client;

  String get endpointBase => _endpointBase;

  Service({String endpointBase, http.Client client})
      : _endpointBase = endpointBase ?? '',
        _client = client ?? http.Client();

  Future<http.Response> getHttpResponse(String endpoint,
      {Map<String, String> headers}) {
    endpoint ??= '';
    return _client.get(Uri.parse(endpointBase + endpoint), headers: headers);
  }

  Future<Response<ResultType>> getResponse<ResultType>(String endpoint,
      ResponseConverter<ResultType, JsonConverter<ResultType>> converter,
      {OnHttpErrorCallback onHttpError, Map<String, String> headers}) async {
    var httpResponse = await getHttpResponse(endpoint, headers: headers);
    Response<ResultType> response;
    if (httpResponse.statusCode == httpStatusCodeOk) {
      response = converter.fromJsonString(httpResponse.body);
    } else {
      onHttpError ??= _defaultHttpErrorHandler;
      onHttpError(httpResponse.statusCode, endpointBase + endpoint);
    }

    return response;
  }

  Future<Response<ResultType>> getResponseDirect<ResultType>(
      String endpoint, JsonConverter<ResultType> converter,
      {OnHttpErrorCallback onHttpError, Map<String, String> headers}) {
    return getResponse(endpoint, ResponseConverter(converter),
        onHttpError: onHttpError, headers: headers);
  }

  void close() {
    _client.close();
  }

  static void _defaultHttpErrorHandler(int statusCode, String endpoint) {
    var uri = Uri.parse(endpoint);
    var message = 'An error occurs during requesting the '
        "'${uri}'. The status code is '$statusCode'";
    throw HttpException(message, uri: uri);
  }
}
