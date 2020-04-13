import 'package:djustin/src/model/branch_locator.dart';
import 'package:djustin/src/model/converter/branch_info.converter.dart';

import 'json_converter.dart';

class BranchLocatorConverter extends JsonConverter<BranchLocator> {
  BranchInfoConverter _branchInfoConverter;

  @override
  BranchLocator fromJson(Map<String, dynamic> json) {
    BranchLocator locator;
    if (json != null) {
      _branchInfoConverter ??= BranchInfoConverter();
      locator =
          BranchLocator(_branchInfoConverter.fromJson(json), json['distance']);
    }
    return locator;
  }
}
