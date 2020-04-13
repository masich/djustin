import 'package:djustin/src/model/branch_format.dart';
import 'package:djustin/src/model/branch_type.dart';
import 'package:djustin/src/model/converter/json_converter.dart';

class BranchTypeConverter extends JsonConverter<BranchType> {
  @override
  BranchType fromJson(Map<String, dynamic> json) {
    BranchType branchType;
    if (json != null) {
      branchType = BranchType(
          BranchFormatExtension.fromString(json['short_name']),
          json['description']);
    }
    return branchType;
  }
}
