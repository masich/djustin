part of 'branch_type.dart';

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

extension BranchFormatExtension on BranchFormat {
  static const String MINI_OSR_STRING = 'MiniOSR';
  static const String OSR_STRING = 'OSR';
  static const String SMART_STRING = 'SMART';
  static const Map<String, BranchFormat> mapping = {
    'MiniOSR': BranchFormat.MINI_OSR,
    'OSR': BranchFormat.OSR,
    'SMART': BranchFormat.SMART
  };

  static BranchFormat fromString(String stringFormat) => mapping[stringFormat];

  String string() => BranchFormatExtension.mapping.keyForValue(this);
}
