import 'package:djustin/src/model/converter/json_converter.dart';
import 'package:djustin/src/model/tracking.dart';

class TrackingConverter extends JsonConverter<Tracking> {
  @override
  Tracking fromJson(Map<String, dynamic> json) {
    Tracking tracking;
    if (json != null) {
      tracking = Tracking(
          int.parse(json['orderNumber']),
          json['orderDescription'],
          DateTime.parse("${json['date']} ${json['time']}"),
          json['status'],
          json['departmentNumber'],
          json['departmentAdress']);
    }
    return tracking;
  }
}
