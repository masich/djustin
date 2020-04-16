import 'package:djustin/src/model/branch.dart';
import 'package:djustin/src/model/common/locale.dart';
import 'package:djustin/src/model/converter/branch_info.converter.dart';
import 'package:djustin/src/model/converter/json_converter.dart';

class BranchConverter extends JsonConverter<Branch> {
  static const int _serviceAvailable = 1;

  PublicInfoConverter _infoConverter;
  BranchInfoConverter _branchInfoConverter;

  static List<Uri> _parsePhotosUrls(List<dynamic> photosUrls) {
    return photosUrls?.map((e) => Uri.parse(e as String))?.toList();
  }

  static Map<String, bool> _parseServices(Map<String, dynamic> services) {
    return services?.map((k, e) => MapEntry(k, (e as int) == _serviceAvailable));
  }

  @override
  Branch fromJson(Map<String, dynamic> json) {
    Branch branch;
    if (json != null) {
      _infoConverter ??= PublicInfoConverter();
      _branchInfoConverter ??= BranchInfoConverter();
      branch = Branch(_branchInfoConverter.fromJson(json), _parsePhotosUrls(json['photos'] as List<dynamic>),
          _parseServices(json['services'] as Map<String, dynamic>), _infoConverter.fromJson(json['public']));
    }
    return branch;
  }
}

class PublicInfoConverter extends JsonConverter<PublicInfo> {
  @override
  PublicInfo fromJson(Map<String, dynamic> json) {
    PublicInfo publicInfo;
    if (json != null) {
      var description = Locale.parseLocalizedText('public_description_', json);
      var navigation = Locale.parseLocalizedText('navigation_', json);
      publicInfo = PublicInfo(description, navigation);
    }
    return publicInfo;
  }
}
