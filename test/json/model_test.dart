import 'package:djustin/converters.dart';
import 'package:djustin/djustin.dart';
import 'package:test/test.dart';

import 'jsons.dart';

void main() {
  group('djustin models tests', () {
    modelNullResultTest();
    modelBranchTypeTest();
    modelNullResultTest();
    modelBranchTest();
    modelTrackingTest();
    modelServiceInfoTest();
    modelLocalitiesTest();
    modelBranchLocatorTest();
  });
}

void modelNullResultTest() {
  Response response;

  setUp(() {
    response =
        ResponseConverter(null).fromJsonString(responseNullResultRawJson);
  });
  test('Model null response test', () {
    var expectedString = 'Response { '
        'status: 0, '
        'message: ResponseMessage { '
        'code: 10104, '
        'text: {'
        'Language.UA: Відділення з вказаним номером не знайдено, '
        'Language.EN: Branch with the specified number not found, '
        'Language.RU: Отделение с указанным номером не найдено'
        '} '
        '},'
        ' results: null '
        '}';
    expect(response.toString(), expectedString);
  });
}

void modelBranchTypeTest() {
  Response<BranchType> response;

  setUp(() {
    response = ResponseConverter(BranchTypeConverter())
        .fromJsonString(branchTypeRawJson);
  });

  test('Model branch type test', () {
    var expectedString = 'BranchType { '
        'format: SMART, '
        'description: SMART – відділення, у якому здійснюється приймання/видача '
        'відправлення вагою не більше ніж 15 кг та з максимальною довжиною '
        'однієї зі сторін не більше ніж 90 см. '
        '}';
    expect(response.results.first.toString(), expectedString);
  });
}

void modelBranchTest() {
  Response<Branch> response;

  setUp(() {
    response =
        ResponseConverter(BranchConverter()).fromJsonString(branchRawJson);
  });

  test('Model branch test', () {
    var expectedString = 'Branch { '
        'branchInfo: BranchInfo { '
        'number: 2, '
        'address: Київ, Драйзера вул., 8  (Сільпо), '
        'locality: Київ, '
        'type: Відділення, '
        'format: OSR, '
        'deliveryBranchId: 7100103004, '
        'maxWeight: 30, '
        'latitude: 50.5025327, '
        'longitude: 30.6051219, '
        'description: Відділення 2, '
        'scheduleDescription: ПН-ПТ 10:00-19:00,СБ-НД 11:00-17:00'
        '}, '
        'photos: ['
        'https://public.justin.ua/img/7467.JPG, '
        'https://public.justin.ua/img/6883.jpg'
        '], '
        'servicesAvailability: {'
        'monobank: true, '
        'cardpay: false, '
        'vending: false, '
        'remittance: false, '
        'fitting: false, '
        '3mob: true, '
        'uplata: true, '
        'joint: false'
        '}, '
        'publicInfo: PublicInfo {'
        'description: {'
        'Language.UA: , '
        'Language.EN: , '
        'Language.RU: '
        '}, '
        'navigation: {'
        'Language.UA: Окреме приміщення, вхід з вул. Теодора Драйзера, '
        "ліворуч від ''Сільпо'', "
        'Language.EN: Separate room, entrance from str. Theodore Dreiser, '
        "left of ''Silpo'', "
        'Language.RU: Отдельное здание, вход с ул. Теодора Драйзера, '
        "слева от ''Сильпо''"
        '} '
        '} '
        '}';
    expect(response.results.first.toString(), expectedString);
  });
}

void modelTrackingTest() {
  Response<Tracking> response;

  setUp(() {
    response = ResponseConverter(TrackingConverter())
        .fromJsonString(responseTrackingRawJson);
  });

  test('Model tracking test', () {
    var expectedString = 'Tracking { '
        'orderNumber: 201810165, '
        'orderDescription: Замовлення клієнта 201810165 від 25.07.2018, '
        'dateTime: 2019-02-27 10:20:51.000, '
        'status: Одержано, '
        'departmentNumber: , '
        'departmentAddress:  '
        '}';
    expect(response.results.first.toString(), expectedString);
  });
}

void modelServiceInfoTest() {
  Response<ServiceInfo> response;

  setUp(() {
    response = ResponseConverter(ServiceInfoConverter())
        .fromJsonString(responseServicesInfoRawJson);
  });

  test('Model service info test', () {
    var expectedString = 'ServiceInfo { '
        'id: monobank, '
        'name: {'
        'Language.UA: Картка "Монобанк", '
        'Language.EN: Monobank Card, '
        'Language.RU: Карта "Монобанк"'
        '}, '
        'description: {'
        'Language.UA: Можна отримати карту Monobank, '
        'Language.EN: Можна отримати карту Monobank, '
        'Language.RU: Можна отримати карту Monobank'
        '}, '
        'alias: monobank, '
        'hasSelfService: false, '
        'hasCategoryService: true, '
        'hasSendService: true '
        '}';
    expect(response.results.first.toString(), expectedString);
  });
}

void modelLocalitiesTest() {
  Response<Locality> response;

  setUp(() {
    response = ResponseConverter(LocalityConverter())
        .fromJsonString(responseLocalitiesRawJson);
  });

  test('Model locality test', () {
    var expectedString = 'Locality { '
        'uuid: 82362067-dc04-11e7-80c6-00155dfbfb00, '
        'scoatou: 3510300000, '
        'parentUuid: 17bc2896-dbfe-11e7-80c6-00155dfbfb00, '
        'title: {'
        'Language.UA: Олександрія, '
        'Language.EN: , '
        'Language.RU: Александрия'
        '}, '
        'parentTitle: {'
        'Language.UA: Кіровоградська, '
        'Language.EN: , '
        'Language.RU: Кировоградская'
        '} '
        '}';
    expect(response.results.first.toString(), expectedString);
  });
}

void modelBranchLocatorTest() {
  Response<BranchLocator> response;

  setUp(() {
    response = ResponseConverter(BranchLocatorConverter())
        .fromJsonString(responseBranchLocatorRawJson);
  });

  test('Model branch locator test', () {
    var expectedString = 'BranchLocator { '
        'branchInfo: BranchInfo { '
        'number: 258, '
        'address: Київ, Січових Стрільців вул. , 37/41 (Сільпо), '
        'locality: Київ, type: Відділення, '
        'format: SMART, '
        'deliveryBranchId: 7100110258, '
        'maxWeight: 15, '
        'latitude: 50.456107, '
        'longitude: 30.496798, '
        'description: Відділення №258, '
        'scheduleDescription: ПН-НД 08-20'
        '}, '
        'distance: 1.33 '
        '}';
    expect(response.results.first.toString(), expectedString);
  });
}
