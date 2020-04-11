part of 'branch_type.dart';

class BranchTypeConverter implements JsonConverter<BranchType> {
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
