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
      await requestResponse(service);
      await requestError(service);
    });

    test('Justin service tests', () async {
      await requestBranchTypes(service);
      await requestTracking(service);
      await requestTrackingHistory(service);
      await requestLocalitiesAll(service);
      await requestLocalitiesActive(service);
      await requestServicesInfo(service);
      await requestBranchesAll(service);
      await requestBranches(service);
      await requestBranchLocators(service);
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

void requestTracking(JustinService service) async {
  var response = await service.getTracking('201810165');

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 1);
}

void requestTrackingHistory(JustinService service) async {
  var response = await service.getTrackingHistory('201810165');

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 6);
}

void requestLocalitiesAll(JustinService service) async {
  var response = await service.getLocalitiesAll();

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThan(1));
}

void requestLocalitiesActive(JustinService service) async {
  var response = await service.getLocalitiesAll();

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThanOrEqualTo(0));
}

void requestServicesInfo(JustinService service) async {
  var response = await service.getServicesInfo();

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThan(0));
}

void requestBranchesAll(JustinService service) async {
  var response = await service.getBranchesAll();

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThan(0));
}

void requestBranch(JustinService service) async {
  var response = await service.getBranch(220);

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, 1);
}

void requestBranches(JustinService service) async {
  var response = await service.getBranches('Kyiv');

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThanOrEqualTo(0));
}

void requestBranchLocators(JustinService service) async {
  var response = await service.getBranchLocators('Kyiv,Shevchenka,30');

  expect(response, isNotNull);
  expect(response.status, 1);
  expect(response.message, isNull);
  expect(response.results, isNotNull);
  expect(response.results.length, greaterThanOrEqualTo(0));
}
