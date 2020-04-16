import 'package:djustin/src/model/converter/json_converter.dart';
import 'package:djustin/src/model/tracking.dart';

class TrackingConverter extends JsonConverter<Tracking> {
  @override
  Tracking fromNotBlankJson(Map<String, dynamic> json) {
    return Tracking(
        int.parse(json['orderNumber']),
        json['orderDescription'],
        DateTime.parse("${json['date']} ${json['time']}"),
        json['status'],
        json['departmentNumber'],
        json['departmentAdress']);
  }
}
