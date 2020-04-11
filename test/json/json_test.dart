import 'dart:convert' as json;
import 'package:djustin/src/model/branch.dart';
import 'package:djustin/src/model/branch_format.dart';
import 'package:djustin/src/model/common/locale.dart';
import 'package:djustin/src/model/service.dart';
import 'package:djustin/src/model/tracking.dart';
import 'package:test/test.dart';

import 'package:djustin/djustin.dart';

import 'jsons.dart';

void jsonConvertersTest() {
  group('Json converters tests', () {
    responseBranchTypeTest();
    responseNullResultTest();
    responseBranchTest();
    responseTrackingTest();
    responseServicesTest();
  });
}

void testResponseStaticFieldsOk(Response response) {
  expect(response.status, 1);
  expect(response.message, isNull);
}

final Map<String, dynamic> branchTypeJson = json.jsonDecode(branchTypeRawJson);

void responseBranchTypeTest() {
  var converter;
  var response;

  setUp(() {
    converter = ResponseConverter<BranchType, BranchTypeConverter>();
    response = converter.fromJson(branchTypeJson);
  });

  test('BranchType json response test', () {
    testResponseStaticFieldsOk(response);
    expect(response.results.length, 1);

    BranchType branchType = response.results.first;
    expect(branchType, isNotNull);
    expect(branchType.format, BranchFormat.SMART);
    expect(branchType.description,
        '''SMART – відділення, у якому здійснюється приймання/видача відправлення вагою не більше ніж 15 кг та з максимальною довжиною однієї зі сторін не більше ніж 90 см.''');
  });
}

final Map<String, dynamic> responseNullResultJson =
    json.jsonDecode(responseNullResultRawJson);

void responseNullResultTest() {
  var converter;
  var response;

  setUp(() {
    converter = ResponseConverter();
    response = converter.fromJson(responseNullResultJson);
  });

  test('Response null result test', () {
    expect(response.status, 0);
    expect(response.message, isNotNull);

    ResponseMessage message = response.message;
    expect(message.code, 10104);
    var text = message.text;
    expect(text[Language.UA], 'Відділення з вказаним номером не знайдено');
    expect(text[Language.EN], 'Branch with the specified number not found');
    expect(text[Language.RU], 'Отделение с указанным номером не найдено');
  });
}

final Map<String, dynamic> branchJson = json.jsonDecode(branchRawJson);

void responseBranchTest() {
  ResponseConverter<Branch, BranchConverter> converter;
  var response;

  setUp(() {
    converter = ResponseConverter<Branch, BranchConverter>();
    response = converter.fromJson(branchJson);
  });

  test('Branch json response test', () {
    testResponseStaticFieldsOk(response);
    expect(response.results.length, 2);

    Branch branchFirst = response.results.first;
    expect(branchFirst, isNotNull);

    expect(branchFirst.number, 2);
    expect(branchFirst.address, 'Київ, Драйзера вул., 8  (Сільпо)');
    expect(branchFirst.locality, 'Київ');
    expect(branchFirst.type, 'Відділення');
    expect(branchFirst.format, BranchFormat.OSR);
    expect(branchFirst.deliveryBranchId, '7100103004');
    expect(branchFirst.maxWeight, 30);
    expect(branchFirst.latitude, '50.5025327');
    expect(branchFirst.longitude, '30.6051219');
    expect(branchFirst.description, 'Відділення 2');
    expect(
        branchFirst.scheduleDescription, 'ПН-ПТ 10:00-19:00,СБ-НД 11:00-17:00');

    expect(branchFirst.photos.length, 2);
    expect(branchFirst.photos[0],
        Uri.parse('https://public.justin.ua/img/7467.JPG'));
    expect(branchFirst.photos[1],
        Uri.parse('https://public.justin.ua/img/6883.jpg'));

    expect(branchFirst.services.length, 8);
    expect(branchFirst.services['monobank'], isTrue);
    expect(branchFirst.services['cardpay'], isFalse);
    expect(branchFirst.services['vending'], isFalse);
    expect(branchFirst.services['remittance'], isFalse);
    expect(branchFirst.services['fitting'], isFalse);
    expect(branchFirst.services['3mob'], isTrue);
    expect(branchFirst.services['uplata'], isTrue);
    expect(branchFirst.services['joint'], isFalse);

    var description = branchFirst.publicInfo.description;
    expect(description.length, 3);
    expect(description[Language.UA], isEmpty);
    expect(description[Language.EN], isEmpty);
    expect(description[Language.RU], isEmpty);

    var navigation = branchFirst.publicInfo.navigation;
    expect(navigation.length, 3);
    expect(navigation[Language.UA],
        "Окреме приміщення, вхід з вул. Теодора Драйзера, ліворуч від ''Сільпо''");
    expect(navigation[Language.EN],
        "Separate room, entrance from str. Theodore Dreiser, left of ''Silpo''");
    expect(navigation[Language.RU],
        "Отдельное здание, вход с ул. Теодора Драйзера, слева от ''Сильпо''");
  });
}

final Map<String, dynamic> responseTrackingJson =
    json.jsonDecode(responseTrackingRawJson);

void responseTrackingTest() {
  var converter;
  Response<Tracking> response;

  setUp(() {
    converter = ResponseConverter<Tracking, TrackingConverter>();
    response = converter.fromJson(responseTrackingJson);
  });

  test('Tracking json response test', () {
    testResponseStaticFieldsOk(response);
    expect(response.results.length, 1);

    var tracking = response.results.first;
    expect(tracking, isNotNull);

    expect(tracking.orderNumber, 201810165);
    expect(tracking.orderDescription,
        'Замовлення клієнта 201810165 від 25.07.2018');
    expect(tracking.dateTime, DateTime.parse('2019-02-27 10:20:51'));
    expect(tracking.status, 'Одержано');
    expect(tracking.departmentNumber, isEmpty);
    expect(tracking.departmentAddress, isEmpty);
  });
}

final Map<String, dynamic> responseServicesJson =
    json.jsonDecode(responseServicesRawJson);

void responseServicesTest() {
  var converter;
  Response<Service> response;

  setUp(() {
    converter = ResponseConverter<Service, ServiceConverter>();
    response = converter.fromJson(responseServicesJson);
  });

  test('Services json response test', () {
    testResponseStaticFieldsOk(response);
    expect(response.results.length, 2);

    var service = response.results.first;
    expect(service, isNotNull);

    expect(service.id, 'monobank');

    var name = service.name;
    expect(name[Language.UA], 'Картка "Монобанк"');
    expect(name[Language.EN], 'Monobank Card');
    expect(name[Language.RU], 'Карта "Монобанк"');

    var description = service.description;
    expect(description[Language.UA], 'Можна отримати карту Monobank');
    expect(description[Language.EN], 'Можна отримати карту Monobank');
    expect(description[Language.RU], 'Можна отримати карту Monobank');

    expect(service.alias, 'monobank');
    expect(service.selfService, false);
    expect(service.categoryService, true);
    expect(service.sendService, true);
  });
}
