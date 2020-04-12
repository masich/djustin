import 'package:djustin/src/model/common/locale.dart';

class Service {
  final String id;

  // jsonName: name_ua, name_en, name_ru
  final Map<Language, String> name;

  // jsonName: description_ua, description_en, description_ru
  final Map<Language, String> description;
  final String alias;

  // jsonName: self_service
  final bool hasSelfService;

  // jsonName: category_service
  final bool hasCategoryService;

  // jsonName: send_service
  final bool hasSendService;

  Service(this.id, this.name, this.description, this.alias, this.hasSelfService,
      this.hasCategoryService, this.hasSendService);
}
