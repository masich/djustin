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

import 'package:djustin/src/model/common/json_converter.dart';
import 'package:djustin/src/model/common/locale.dart';

part 'service.converter.dart';

class Service {
  final String id;

  // jsonName: name_ua, name_en, name_ru
  final Map<Language, String> name;

  // jsonName: description_ua, description_en, description_ru
  final Map<Language, String> description;
  final String alias;

  // jsonName: self_service
  final bool selfService;

  // jsonName: category_service
  final bool categoryService;

  // jsonName: send_service
  final bool sendService;

  Service(this.id, this.name, this.description, this.alias, this.selfService,
      this.categoryService, this.sendService);
}
