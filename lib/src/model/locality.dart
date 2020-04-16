import 'package:djustin/djustin.dart';

class Locality {
  final String uuid;

  // jsonName: SCOATOU
  final String scoatou;

  // jsonName: parent_uuid
  final String parentUuid;

  // jsonName: title_ua, title_en, title_ru
  final Map<Language, String> title;

  // jsonName: parent_title_ua, parent_title_en, parent_title_ru
  final Map<Language, String> parentTitle;

  Locality(this.uuid, this.scoatou, this.parentUuid, this.title, this.parentTitle);

  @override
  String toString() {
    return 'Locality {'
        'uuid: $uuid, '
        'scoatou: $scoatou, '
        'parentUuid: $parentUuid, '
        'title: $title, '
        'parentTitle: $parentTitle'
        '}';
  }
}
