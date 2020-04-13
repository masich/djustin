import 'package:djustin/src/model/common/locale.dart';
import 'package:djustin/src/model/converter/json_converter.dart';
import 'package:djustin/src/model/locality.dart';

class LocalityConverter extends JsonConverter<Locality> {
  @override
  Locality fromJson(Map<String, dynamic> json) {
    Locality locality;
    if (json != null && json.isNotEmpty) {
      var title = <Language, String>{
        Language.UA: json['title_ua'],
        Language.EN: json['title_en'],
        Language.RU: json['title_ru']
      };
      var parentTitle = <Language, String>{
        Language.UA: json['parent_title_ua'],
        Language.EN: json['parent_title_en'],
        Language.RU: json['parent_title_ru']
      };

      locality = Locality(json['uuid'], json['SCOATOU'], json['parent_uuid'],
          title, parentTitle);
    }
    return locality;
  }
}
