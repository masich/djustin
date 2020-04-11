part of 'tracking.dart';

class TrackingConverter implements JsonConverter<Tracking> {
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

  @override
  Map<String, dynamic> toJson(Tracking value) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
