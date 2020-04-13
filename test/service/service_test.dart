import 'dart:io';

import 'package:djustin/converters.dart';
import 'package:djustin/djustin.dart';
import 'package:test/test.dart';

void main() {
  group('djustin service tests', () {
    JustinService service;
    setUp(() {
      service = JustinService();
    });

    test('Justin service simple tests', () async {
      await requestResponseTest(service);
      await requestErrorTest(service);
    });

    test('Justin request branch types service tests', () async {
      await requestBranchTypesTest(service);
    });
    test('Justin request tracking service tests', () async {
      await requestTrackingTest(service);
    });
    test('Justin request tracking history service tests', () async {
      await requestTrackingHistoryTest(service);
    });
    test('Justin request localities all tests', () async {
      await requestLocalitiesAllTest(service);
    });
    test('Justin request localities active tests', () async {
      await requestLocalitiesActiveTest(service);
    });
    test('Justin request services info service tests', () async {
      await requestServicesInfoTest(service);
    });
    test('Justin request branches all service tests', () async {
      await requestBranchesAllTest(service);
    });
    test('Justin request branches for urban ares service tests', () async {
      await requestBranchesTest(service);
    });
    test('Justin request branch locators service tests', () async {
      await requestBranchLocatorsTest(service);
    });
    test('Justin http error handling service tests', () async {
      await requestHttpErrorHandlerTest();
    });
    test('Justin http default error handling service tests', () async {
      await requestHttpDefaultErrorHandlerTest();
    });

    tearDown(() {
      service.close();
    });
  });
}

void requestResponseTest(JustinService service) async {
  var converter = BranchTypeConverter();
  var response =
      await service.getResponseDirect(Endpoint.branchTypes, converter);

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 3);
}

void requestHttpErrorHandlerTest() async {
  var service = Service(endpointBase: 'https://httpstat.us/404');
  var statusCode;
  var response = await service.getResponse('', null, onError: (code) {
    statusCode = code;
  });

  expect(response, isNull);
  expect(statusCode, isNotNull);
  expect(statusCode, 404);
}

void requestHttpDefaultErrorHandlerTest() async {
  var service = Service(endpointBase: 'https://httpstat.us/404');
  expect(() async {
    await service.getResponse('', null);
  }, throwsA(TypeMatcher<HttpException>()));
}

void requestErrorTest(JustinService service) async {
  var response = await service.getResponseDirect('/error_error', null);

  expect(response, isNotNull);
  expect(response.status, 0);
  expect(response.message, isNotNull);
  expect(response.results, isNull);
}

void requestBranchTypesTest(JustinService service) async {
  var response = await service.getBranchTypes();

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 3);
}

void requestTrackingTest(JustinService service) async {
  var response = await service.getTracking('201810165');

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 1);
}

void requestTrackingHistoryTest(JustinService service) async {
  var response = await service.getTrackingHistory('201810165');

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 6);
}

void requestLocalitiesAllTest(JustinService service) async {
  var response = await service.getLocalitiesAll();

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThan(1));
}

void requestLocalitiesActiveTest(JustinService service) async {
  var response = await service.getLocalitiesActive();

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThanOrEqualTo(0));
}

void requestServicesInfoTest(JustinService service) async {
  var response = await service.getServicesInfo();

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThan(0));
}

void requestBranchesAllTest(JustinService service) async {
  var response = await service.getBranchesAll();

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThan(0));
}

void requestBranchTest(JustinService service) async {
  var response = await service.getBranch(220);

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 1);
}

void requestBranchesTest(JustinService service) async {
  var response = await service.getBranches('Kyiv');

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThanOrEqualTo(0));
}

void requestBranchLocatorsTest(JustinService service) async {
  var response = await service.getBranchLocators('Kyiv,Shevchenka,30');

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThanOrEqualTo(0));
}
