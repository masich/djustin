import 'package:djustin/converters.dart';
import 'package:djustin/djustin.dart';
import 'package:djustin/src/model/converter/branch.converter.dart';
import 'package:djustin/src/model/converter/branch_type.converter.dart';
import 'package:djustin/src/model/converter/response.converter.dart';
import 'package:djustin/src/model/converter/service_info.converter.dart';
import 'package:djustin/src/model/converter/tracking.converter.dart';
import 'package:test/test.dart';

import 'jsons.dart';

void main() {
  group('djustin json converters tests', () {
    responseBranchTypeTest();
    responseNullResultTest();
    responseBranchTest();
    responseTrackingTest();
    responseServicesTest();
    responseLocalitiesTest();
    responseBranchLocatorTest();
  });
}

void testResponseStaticFieldsOk(Response response) {
  expect(response.status, 1);
  expect(response.message, isNull);
}

void responseBranchTypeTest() {
  Response<BranchType> response;

  setUp(() {
    response = ResponseConverter<BranchType, BranchTypeConverter>()
        .fromJsonString(branchTypeRawJson);
  });

  test('BranchType json response test', () {
    testResponseStaticFieldsOk(response);
    expect(response.results.length, 1);

    var branchType = response.results.first;
    expect(branchType, isNotNull);
    expect(branchType.format, BranchFormat.SMART);
    expect(branchType.description,
        '''SMART – відділення, у якому здійснюється приймання/видача відправлення вагою не більше ніж 15 кг та з максимальною довжиною однієї зі сторін не більше ніж 90 см.''');
  });
}

void responseNullResultTest() {
  Response response;

  setUp(() {
    response = ResponseConverter().fromJsonString(responseNullResultRawJson);
  });

  test('Response null result test', () {
    expect(response.status, 0);
    expect(response.message, isNotNull);

    var message = response.message;
    expect(message.code, 10104);
    var text = message.text;
    expect(text[Language.UA], 'Відділення з вказаним номером не знайдено');
    expect(text[Language.EN], 'Branch with the specified number not found');
    expect(text[Language.RU], 'Отделение с указанным номером не найдено');
  });
}

void responseBranchTest() {
  Response<Branch> response;

  setUp(() {
    response = ResponseConverter<Branch, BranchConverter>()
        .fromJsonString(branchRawJson);
  });

  test('Branch json response test', () {
    testResponseStaticFieldsOk(response);
    expect(response.results.length, 2);

    var branchFirst = response.results.first;
    expect(branchFirst, isNotNull);

    expect(branchFirst.branchInfo.number, 2);
    expect(branchFirst.branchInfo.address, 'Київ, Драйзера вул., 8  (Сільпо)');
    expect(branchFirst.branchInfo.locality, 'Київ');
    expect(branchFirst.branchInfo.type, 'Відділення');
    expect(branchFirst.branchInfo.format, BranchFormat.OSR);
    expect(branchFirst.branchInfo.deliveryBranchId, '7100103004');
    expect(branchFirst.branchInfo.maxWeight, 30);
    expect(branchFirst.branchInfo.latitude, '50.5025327');
    expect(branchFirst.branchInfo.longitude, '30.6051219');
    expect(branchFirst.branchInfo.description, 'Відділення 2');
    expect(branchFirst.branchInfo.scheduleDescription,
        'ПН-ПТ 10:00-19:00,СБ-НД 11:00-17:00');

    expect(branchFirst.photos.length, 2);
    expect(branchFirst.photos[0],
        Uri.parse('https://public.justin.ua/img/7467.JPG'));
    expect(branchFirst.photos[1],
        Uri.parse('https://public.justin.ua/img/6883.jpg'));

    expect(branchFirst.servicesAvailability.length, 8);
    expect(branchFirst.servicesAvailability['monobank'], isTrue);
    expect(branchFirst.servicesAvailability['cardpay'], isFalse);
    expect(branchFirst.servicesAvailability['vending'], isFalse);
    expect(branchFirst.servicesAvailability['remittance'], isFalse);
    expect(branchFirst.servicesAvailability['fitting'], isFalse);
    expect(branchFirst.servicesAvailability['3mob'], isTrue);
    expect(branchFirst.servicesAvailability['uplata'], isTrue);
    expect(branchFirst.servicesAvailability['joint'], isFalse);

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

void responseTrackingTest() {
  Response<Tracking> response;

  setUp(() {
    response = ResponseConverter<Tracking, TrackingConverter>()
        .fromJsonString(responseTrackingRawJson);
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

void responseServicesTest() {
  Response<ServiceInfo> response;

  setUp(() {
    response = ResponseConverter<ServiceInfo, ServiceInfoConverter>()
        .fromJsonString(responseServicesRawJson);
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
    expect(service.hasSelfService, false);
    expect(service.hasCategoryService, true);
    expect(service.hasSendService, true);
  });
}

void responseLocalitiesTest() {
  Response<Locality> response;

  setUp(() {
    response = ResponseConverter<Locality, LocalityConverter>()
        .fromJsonString(responseLocalitiesRawJson);
  });

  test('Localities json response test', () {
    testResponseStaticFieldsOk(response);
    expect(response.results.length, 2);

    var locality = response.results.first;
    expect(locality, isNotNull);

    expect(locality.uuid, '82362067-dc04-11e7-80c6-00155dfbfb00');
    expect(locality.scoatou, '3510300000');
    expect(locality.parentUuid, '17bc2896-dbfe-11e7-80c6-00155dfbfb00');

    expect(locality.title[Language.UA], 'Олександрія');
    expect(locality.title[Language.EN], isEmpty);
    expect(locality.title[Language.RU], 'Александрия');

    expect(locality.parentTitle[Language.UA], 'Кіровоградська');
    expect(locality.parentTitle[Language.EN], isEmpty);
    expect(locality.parentTitle[Language.RU], 'Кировоградская');
  });
}

void responseBranchLocatorTest() {
  Response<BranchLocator> response;

  setUp(() {
    response = ResponseConverter<BranchLocator, BranchLocatorConverter>()
        .fromJsonString(responseBranchLocatorRawJson);
  });

  test('Branch locator json response test', () {
    testResponseStaticFieldsOk(response);
    expect(response.results.length, 2);

    var locator = response.results.first;
    expect(locator, isNotNull);

    expect(locator.branchInfo.number, 258);
    expect(locator.branchInfo.address,
        'Київ, Січових Стрільців вул. , 37/41 (Сільпо)');
    expect(locator.branchInfo.locality, 'Київ');
    expect(locator.branchInfo.type, 'Відділення');
    expect(locator.branchInfo.format, BranchFormat.SMART);
    expect(locator.branchInfo.deliveryBranchId, '7100110258');
    expect(locator.branchInfo.maxWeight, 15);
    expect(locator.branchInfo.latitude, '50.456107');
    expect(locator.branchInfo.longitude, '30.496798');
    expect(locator.branchInfo.description, 'Відділення №258');
    expect(locator.branchInfo.scheduleDescription, 'ПН-НД 08-20');
    expect(locator.distance, 1.33);
  });
}
