import 'package:djustin/converters.dart';
import 'package:djustin/src/model/branch_format.dart';
import 'package:djustin/src/model/branch_info.dart';

class BranchInfoConverter extends JsonConverter<BranchInfo> {
  @override
  BranchInfo fromNotBlankJson(Map<String, dynamic> json) {
    return BranchInfo(
      int.parse(json['number']),
      json['adress'],
      json['locality'],
      json['type'],
      BranchFormatExtension.fromString(json['format']),
      json['delivery_branch_id'],
      int.parse(json['max_weight']),
      json['lat'],
      json['lng'],
      json['description'],
      json['shedule_description'],
    );
  }
}
