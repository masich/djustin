//"monobank": {
//"name_ru": "Карта \"Монобанк\"",
//"name_ua": "Картка \"Монобанк\"",
//"name_en": "Monobank Card",
//"description_ru": "Можна отримати карту Monobank",
//"description_ua": "Можна отримати карту Monobank",
//"description_en": "Можна отримати карту Monobank",
//"alias": "monobank",
//"self_service": "0",
//"category_service": "1",
//"send_service": "1"
//}
//
//import 'package:djustin/src/model/common/locale.dart';
//
//class Service {
//  final String id;
//
//  // jsonName: name_ua, name_en, name_ru
//  final Map<Language, String> name;
//
//  // jsonName: description_ua, description_en, description_ru
//  final Map<Language, String> description;
//  final String alias;
//
//  // jsonName: self_service
//  final bool selfService
//
//  // jsonName: category_service
//  final bool categoryService
//
//  // jsonName: send_service
//  final bool sendService
//}

part of 'service.dart';

class ServiceConverter implements JsonConverter<Service> {
  static const String _serviceTrue = '1';

  @override
  Service fromJson(Map<String, dynamic> json) {
    Service service;
    if (json != null && json.isNotEmpty) {
      var id = json.keys.first;
      json = json[id];

      var name = <Language, String>{
        Language.UA: json['name_ua'],
        Language.EN: json['name_en'],
        Language.RU: json['name_ru']
      };
      var description = <Language, String>{
        Language.UA: json['description_ua'],
        Language.EN: json['description_en'],
        Language.RU: json['description_ru']
      };

      service = Service(
          id,
          name,
          description,
          json['alias'],
          json['self_service'] == _serviceTrue,
          json['category_service'] == _serviceTrue,
          json['send_service'] == _serviceTrue);
    }
    return service;
  }

  @override
  Map<String, dynamic> toJson(Service value) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
