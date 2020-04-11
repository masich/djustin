import 'dart:convert' as json;
import 'package:djustin/src/model/common/enums.dart';
import 'package:test/test.dart';

import 'package:djustin/djustin.dart';

void jsonConvertersTest() {
  group('Json converters tests', () {
    responseBranchTypeTest();
    responseNullResultTest();
  });
}

const String branchTypeRawJson = '''
{
  "status": 1,
  "msg": null,
  "result": [
    {
      "short_name":  "SMART",
      "description":  "SMART – відділення, у якому здійснюється приймання/видача відправлення вагою не більше ніж 15 кг та з максимальною довжиною однієї зі сторін не більше ніж 90 см."
    }
  ]
}''';
final Map<String, dynamic> branchTypeJson = json.jsonDecode(branchTypeRawJson);

void responseBranchTypeTest() {
  var converter;
  var response;

  setUp(() {
    converter = ResponseConverter<BranchType, BranchTypeConverter>();
    response = converter.fromJson(branchTypeJson);
  });

  test('BranchType json response test', () {
    expect(response.status, 1);
    expect(response.message, isNull);
    expect(response.results.length, 1);

    BranchType branchType = response.results.first;
    expect(branchType, isNotNull);
    expect(branchType.format, BranchFormat.SMART);
    expect(branchType.description,
        '''SMART – відділення, у якому здійснюється приймання/видача відправлення вагою не більше ніж 15 кг та з максимальною довжиною однієї зі сторін не більше ніж 90 см.''');
  });
}

const String responseNullResultRawJson = '''
{
  "status": 0,
  "msg": {
    "code":  10104,
    "ru":  "Отделение с указанным номером не найдено",
    "ua":  "Відділення з вказаним номером не знайдено",
    "en":  "Branch with the specified number not found"
  },
  "result": null
}''';
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
