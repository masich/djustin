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

    test('Justin error handling service test', () async {
      await requestHttpErrorHandlerTest();
      await requestErrorHandlerTest(service);
    });
    test('Justin default error handling service test', () async {
      await requestHttpDefaultErrorHandlerTest();
      await requestErrorDefaultHandlerTest(service);
    });
    test('Justin request branch types service test', () async {
      await requestBranchTypesTest(service);
      await responseBranchTypesTest(service);
    });
    test('Justin request tracking service test', () async {
      await requestTrackingTest(service);
      await responseTrackingTest(service);
    });
    test('Justin request tracking history service test', () async {
      await requestTrackingHistoryTest(service);
      await responseTrackingHistoryTest(service);
    });
    test('Justin request localities all test', () async {
      await requestLocalitiesAllTest(service);
      await responseLocalitiesAllTest(service);
    });
    test('Justin request localities active test', () async {
      await requestLocalitiesActiveTest(service);
      await responseLocalitiesActiveTest(service);
    });
    test('Justin request services info service test', () async {
      await requestServicesInfoTest(service);
      await responseServicesInfoTest(service);
    });
    test('Justin request branches all service test', () async {
      await requestBranchesAllTest(service);
      await responseBranchesAllTest(service);
    });
    test('Justin request branch by number service test', () async {
      await requestBranchTest(service);
      await responseBranchTest(service);
    });
    test('Justin request branches for urban ares service test', () async {
      await requestBranchesTest(service);
      await responseBranchesTest(service);
    });
    test('Justin request branch locators service test', () async {
      await requestBranchLocatorsTest(service);
      await responseBranchLocatorsTest(service);
    });

    tearDown(() {
      service.close();
    });
  });
}

void requestResponseTest(JustinService service) async {
  var converter = BranchTypeConverter();
  var response = await service.getResponseDirect(Endpoint.branchTypes, converter);

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 3);
}

void requestErrorTest(JustinService service) async {
  var response = await service.getResponseDirect('/error_error', null);

  expect(response, isNotNull);
  expect(response.status, 0);
  expect(response.message, isNotNull);
  expect(response.results, isNull);
}

void requestHttpErrorHandlerTest() async {
  var service = Service(endpointBase: 'https://httpstat.us/404');
  var statusCode;
  var response = await service.getResponse('', null, onHttpError: (code, _) {
    statusCode = code;
  });

  expect(response, isNull);
  expect(statusCode, isNotNull);
  expect(statusCode, 404);
}

void requestErrorHandlerTest(JustinService service) async {
  var statusCode;
  var response = await service.getTrackingHistory('error', onError: (code, _) {
    statusCode = code;
  });

  expect(response, isNull);
  expect(statusCode, isNotNull);
  expect(statusCode, 0);
}

void requestHttpDefaultErrorHandlerTest() async {
  var service = Service(endpointBase: 'https://httpstat.us/404');
  expect(() async {
    await service.getResponse('', null);
  }, throwsA(TypeMatcher<HttpException>()));
}

void requestErrorDefaultHandlerTest(JustinService service) {
  expect(() async {
    await service.getTrackingHistory('error');
  },
      prints("Justin response contains an error. Status: \'0\'; Message: "
          "\'ResponseMessage {code: 10304, text: {Language.UA: Не вдалося знайти "
          'відправлення, Language.EN: Could not find the shipment, Language.RU: Не '
          "удалось найти отправление}}\'\n"));
}

void requestBranchTypesTest(JustinService service) async {
  var response = await service.getBranchTypesResponse();

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 3);
}

void responseBranchTypesTest(JustinService service) async {
  var branchTypes = await service.getBranchTypes();

  expect(branchTypes, isNotNull);
  expect(branchTypes.length, greaterThanOrEqualTo(3));
}

void requestTrackingTest(JustinService service) async {
  var response = await service.getTrackingResponse('201810165');

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 1);
}

void responseTrackingTest(JustinService service) async {
  var tracking = await service.getTracking('201810165');

  expect(tracking, isNotNull);
}

void requestTrackingHistoryTest(JustinService service) async {
  var response = await service.getTrackingHistoryResponse('201810165');

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 6);
}

void responseTrackingHistoryTest(JustinService service) async {
  var history = await service.getTrackingHistory('201810165');

  expect(history, isNotNull);
  expect(history.length, 6);
}

void requestLocalitiesAllTest(JustinService service) async {
  var response = await service.getLocalitiesAllResponse();

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThan(1));
}

void responseLocalitiesAllTest(JustinService service) async {
  var localities = await service.getLocalitiesAll();

  expect(localities, isNotNull);
  expect(localities.length, greaterThan(1));
}

void requestLocalitiesActiveTest(JustinService service) async {
  var response = await service.getLocalitiesActiveResponse();

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThanOrEqualTo(0));
}

void responseLocalitiesActiveTest(JustinService service) async {
  var localities = await service.getLocalitiesActive();

  expect(localities, isNotNull);
  expect(localities.length, greaterThanOrEqualTo(0));
}

void requestServicesInfoTest(JustinService service) async {
  var response = await service.getServicesInfoResponse();

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThan(0));
}

void responseServicesInfoTest(JustinService service) async {
  var info = await service.getServicesInfo();

  expect(info, isNotNull);
  expect(info.length, greaterThan(0));
}

void requestBranchesAllTest(JustinService service) async {
  var response = await service.getBranchesAllResponse();

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThan(0));
}

void responseBranchesAllTest(JustinService service) async {
  var branches = await service.getBranchesAll();

  expect(branches, isNotNull);
  expect(branches.length, greaterThan(0));
}

void requestBranchTest(JustinService service) async {
  var response = await service.getBranchResponse(220);

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 1);
}

void responseBranchTest(JustinService service) async {
  var branch = await service.getBranch(220);

  expect(branch, isNotNull);
}

void requestBranchesTest(JustinService service) async {
  var response = await service.getBranchesResponse('Kyiv');

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThanOrEqualTo(0));
}

void responseBranchesTest(JustinService service) async {
  var branches = await service.getBranches('Kyiv');

  expect(branches, isNotNull);
  expect(branches.length, greaterThanOrEqualTo(0));
}

void requestBranchLocatorsTest(JustinService service) async {
  var response = await service.getBranchLocatorsResponse('Kyiv,Shevchenka,30');

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThanOrEqualTo(0));
}

void responseBranchLocatorsTest(JustinService service) async {
  var locators = await service.getBranchLocators('Kyiv,Shevchenka,30');

  expect(locators, isNotNull);
  expect(locators.length, greaterThanOrEqualTo(0));
}
