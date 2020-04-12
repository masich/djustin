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

    test('Justin service tests', () async {
      await requestBranchTypes(service);
    });
  });
}

void requestResponse(JustinService service) async {
  var converter = BranchTypeConverter();
  var response =
      await service.getResponseDirect(Endpoint.branchTypes, converter);

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 3);
}

void requestError(JustinService service) async {
  var response = await service.getResponseDirect('/error_error', null);

  expect(response, isNotNull);
  expect(response.status, 0);
  expect(response.message, isNotNull);
  expect(response.results, isNull);
}

void requestBranchTypes(JustinService service) async {
  var response = await service.getBranchTypes();

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 3);
}
