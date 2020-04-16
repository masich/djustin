import 'package:djustin/src/model/common/locale.dart';
import 'package:djustin/src/model/converter/json_converter.dart';
import 'package:djustin/src/model/service_info.dart';

class ServiceInfoConverter extends JsonConverter<ServiceInfo> {
  static const String _serviceTrue = '1';

  @override
  ServiceInfo fromNotBlankJson(Map<String, dynamic> json) {
    final id = json.keys.first;
    json = json[id];

    final name = Locale.parseLocalizedText('name_', json);
    final description = Locale.parseLocalizedText('description_', json);

    return ServiceInfo(id, name, description, json['alias'], json['self_service'] == _serviceTrue,
        json['category_service'] == _serviceTrue, json['send_service'] == _serviceTrue);
  }
}
