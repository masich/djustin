import 'dart:io';

import 'package:djustin/converters.dart';
import 'package:djustin/djustin.dart';
import 'package:djustin/src/service/service.dart';
import 'package:http/http.dart' as http;

typedef OnErrorCallback = void Function(int statusCode);

class Endpoint {
  static const String base = 'http://openapi.justin.ua';
  static const String branches = '/branches';
  static const String branchTypes = '/branch_types';
  static const String branchLocator = '/branches_locator';
  static const String tracking = '/tracking';
  static const String trackingHistory = '/tracking_history';
  static const String localities = '/localities';
  static const String services = '/services';

  Endpoint._();
}

class JustinService extends Service {
  static const int statusCodeOk = 200;

  JustinService({String endpointBase, http.Client client})
      : super(endpointBase: endpointBase, client: client);

  Future<Response<ReturnType>> getResponse<ReturnType>(String endpoint,
      ResponseConverter<ReturnType, JsonConverter<ReturnType>> converter,
      {OnErrorCallback onError, Map<String, String> headers}) async {
    var httpResponse = await get(endpoint, headers: headers);

    Response<ReturnType> response;
    if (httpResponse.statusCode == statusCodeOk) {
      response = converter.fromJsonString(httpResponse.body);
    } else {
      if (onError == null) {
        defaultErrorHandler(httpResponse.statusCode, endpoint);
      } else {
        onError(httpResponse.statusCode);
      }
    }

    return response;
  }

  void defaultErrorHandler(int statusCode, String endpoint) {
    var uri = Uri.parse(endpointBase + endpoint);
    var message = 'An error occurs during requesting the '
        "'${uri}'. The status code is '$statusCode'";
    throw HttpException(message, uri: uri);
  }
}
