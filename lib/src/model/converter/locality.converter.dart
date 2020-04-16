import 'package:djustin/src/model/common/locale.dart';
import 'package:djustin/src/model/converter/json_converter.dart';
import 'package:djustin/src/model/locality.dart';

class LocalityConverter extends JsonConverter<Locality> {
  @override
  Locality fromJson(Map<String, dynamic> json) {
    Locality locality;
    if (json != null && json.isNotEmpty) {
      var title = Locale.parseLocalizedText('title_', json);
      var parentTitle = Locale.parseLocalizedText('parent_title_', json);

      locality = Locality(json['uuid'], json['SCOATOU'], json['parent_uuid'], title, parentTitle);
    }
    return locality;
  }
}
