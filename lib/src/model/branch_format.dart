import 'common/utils.dart';

enum BranchFormat {
  MINI_OSR, // MiniOSR
  OSR, // OSR
  SMART, // SMART
}

extension BranchFormatExtension on BranchFormat {
  static const Map<BranchFormat, String> _mapping = {
    BranchFormat.MINI_OSR: 'MiniOSR',
    BranchFormat.OSR: 'OSR',
    BranchFormat.SMART: 'SMART'
  };

  static BranchFormat fromString(String value) =>
      BranchFormatExtension._mapping.keyForValue(value);

  String string() => _mapping[this];
}
