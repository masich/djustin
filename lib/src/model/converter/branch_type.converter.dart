import 'package:djustin/src/model/converter/json_converter.dart';

import 'package:djustin/src/model/branch_format.dart';
import 'package:djustin/src/model/branch_type.dart';

class BranchTypeConverter extends JsonConverter<BranchType> {
  @override
  BranchType fromJson(Map<String, dynamic> json) {
    return BranchType(BranchFormatExtension.fromString(json['short_name']),
        json['description']);
  }

  @override
  Map<String, dynamic> toJson(BranchType value) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
