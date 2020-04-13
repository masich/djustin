import 'package:djustin/src/model/common/locale.dart';
import 'package:djustin/src/model/converter/json_converter.dart';
import 'package:djustin/src/model/service_info.dart';

class ServiceInfoConverter extends JsonConverter<ServiceInfo> {
  static const String _serviceTrue = '1';

  @override
  ServiceInfo fromJson(Map<String, dynamic> json) {
    ServiceInfo service;
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

      service = ServiceInfo(
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
}
