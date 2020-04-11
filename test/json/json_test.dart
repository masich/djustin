import 'dart:convert' as json;
import 'package:djustin/src/model/branch.dart';
import 'package:djustin/src/model/branch_format.dart';
import 'package:djustin/src/model/common/locale.dart';
import 'package:test/test.dart';

import 'package:djustin/djustin.dart';

import 'jsons.dart';

void jsonConvertersTest() {
  group('Json converters tests', () {
    responseBranchTypeTest();
    responseNullResultTest();
    responseBranchTest();
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
    expect(description[Language.UA], '');
    expect(description[Language.EN], '');
    expect(description[Language.RU], '');

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
