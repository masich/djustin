import 'package:djustin/converters.dart';
import 'package:djustin/djustin.dart';
import 'package:test/test.dart';

void serviceTest() {
  group('Service tests', () {
    JustinService service;
    setUp(() {
      service = JustinService(endpointBase: Endpoint.base);
    });

    test('Justin service simple tests', () async {
      await requestResponse(service);
      await requestError(service);
    });
  });
}

void requestResponse(JustinService service) async {
  var converter = ResponseConverter<BranchType, BranchTypeConverter>();
  var response = await service.getResponse(Endpoint.branchTypes, converter);

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 3);
}

void requestError(JustinService service) async {
  var converter = ResponseConverter();
  var response = await service.getResponse('/error_error', converter);

  expect(response, isNotNull);
  expect(response.status, 0);
  expect(response.message, isNotNull);
  expect(response.results, isNull);
}
