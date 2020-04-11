import 'common/utils.dart';

enum BranchFormat {
  MINI_OSR, // MiniOSR
  OSR, // OSR
  SMART, // SMART
}

extension BranchFormatExtension on BranchFormat {
  static const Map<String, BranchFormat> _mapping = {
    'MiniOSR': BranchFormat.MINI_OSR,
    'OSR': BranchFormat.OSR,
    'SMART': BranchFormat.SMART
  };

  static BranchFormat fromString(String stringFormat) => _mapping[stringFormat];

  String string() => BranchFormatExtension._mapping.keyForValue(this);
}
