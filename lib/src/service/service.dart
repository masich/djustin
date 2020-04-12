import 'package:http/http.dart' as http;

class Service {
  final String endpointBase;
  final http.Client _client;

  Service({String endpointBase, http.Client client})
      : endpointBase = endpointBase ?? '',
        _client = client ?? http.Client();

  Future<http.Response> get(String endpoint, {Map<String, String> headers}) {
    endpoint ??= '';
    return _client.get(Uri.parse(endpointBase + endpoint), headers: headers);
  }
}
