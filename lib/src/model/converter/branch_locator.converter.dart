import 'package:djustin/src/model/branch_locator.dart';
import 'package:djustin/src/model/converter/branch_info.converter.dart';

import 'json_converter.dart';

class BranchLocatorConverter extends JsonConverter<BranchLocator> {
  BranchInfoConverter _branchInfoConverter;

  @override
  BranchLocator fromNotBlankJson(Map<String, dynamic> json) {
    _branchInfoConverter ??= BranchInfoConverter();
    return BranchLocator(_branchInfoConverter.fromJson(json), json['distance']);
  }
}
