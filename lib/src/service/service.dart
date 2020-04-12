import 'dart:io';

import 'package:djustin/converters.dart';
import 'package:djustin/src/model/converter/response.converter.dart';
import 'package:djustin/src/model/response.dart';
import 'package:http/http.dart' as http;

typedef OnErrorCallback = void Function(int statusCode);

class Service {
  static const int statusCodeOk = 200;

  final String _endpointBase;
  final http.Client _client;

  Service({String endpointBase, http.Client client})
      : _endpointBase = endpointBase ?? '',
        _client = client ?? http.Client();

  Future<http.Response> get(String endpoint, {Map<String, String> headers}) {
    endpoint ??= '';
    return _client.get(Uri.parse(_endpointBase + endpoint), headers: headers);
  }

  Future<Response<ReturnType>> getResponse<ReturnType>(String endpoint,
      ResponseConverter<ReturnType, JsonConverter<ReturnType>> converter,
      {OnErrorCallback onError, Map<String, String> headers}) async {
    var httpResponse = await get(endpoint, headers: headers);
    Response<ReturnType> response;
    if (httpResponse.statusCode == statusCodeOk) {
      response = converter.fromJsonString(httpResponse.body);
    } else {
      if (onError == null) {
        _defaultErrorHandler(httpResponse.statusCode, endpoint);
      } else {
        onError(httpResponse.statusCode);
      }
    }

    return response;
  }

  Future<Response<ReturnType>> getResponseDirect<ReturnType>(
      String endpoint, JsonConverter<ReturnType> converter,
      {OnErrorCallback onError, Map<String, String> headers}) {
    return getResponse(endpoint, ResponseConverter(resultConverter: converter));
  }

  void _defaultErrorHandler(int statusCode, String endpoint) {
    var uri = Uri.parse(_endpointBase + endpoint);
    var message = 'An error occurs during requesting the '
        "'${uri}'. The status code is '$statusCode'";
    throw HttpException(message, uri: uri);
  }
}
