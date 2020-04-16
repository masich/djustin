import 'package:djustin/src/model/common/locale.dart';
import 'package:djustin/src/model/converter/json_converter.dart';
import 'package:djustin/src/model/locality.dart';

class LocalityConverter extends JsonConverter<Locality> {
  @override
  Locality fromNotBlankJson(Map<String, dynamic> json) {
    var title = Locale.parseLocalizedText('title_', json);
    var parentTitle = Locale.parseLocalizedText('parent_title_', json);

    return Locality(json['uuid'], json['SCOATOU'], json['parent_uuid'], title, parentTitle);
  }
}
