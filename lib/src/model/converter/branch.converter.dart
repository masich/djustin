import 'package:djustin/src/model/branch.dart';
import 'package:djustin/src/model/common/locale.dart';
import 'package:djustin/src/model/converter/branch_info.converter.dart';
import 'package:djustin/src/model/converter/json_converter.dart';

class BranchConverter extends JsonConverter<Branch> {
  static const int _serviceAvailable = 1;

  PublicInfoConverter _publicInfoConverter;
  BranchInfoConverter _branchInfoConverter;

  static List<Uri> _parsePhotosUrls(List<dynamic> photosUrls) {
    return photosUrls?.map((e) => Uri.parse(e as String))?.toList();
  }

  static Map<String, bool> _parseServices(Map<String, dynamic> services) {
    return services?.map((service, availability) =>
        MapEntry(service, availability == _serviceAvailable));
  }

  @override
  Branch fromNotBlankJson(Map<String, dynamic> json) {
    _publicInfoConverter ??= PublicInfoConverter();
    _branchInfoConverter ??= BranchInfoConverter();
    return Branch(
        _branchInfoConverter.fromJson(json),
        _parsePhotosUrls(json['photos']),
        _parseServices(json['services']),
        _publicInfoConverter.fromJson(json['public']));
  }
}

class PublicInfoConverter extends JsonConverter<PublicInfo> {
  @override
  PublicInfo fromNotBlankJson(Map<String, dynamic> json) {
    final description = Locale.parseLocalizedText('public_description_', json);
    final navigation = Locale.parseLocalizedText('navigation_', json);
    return PublicInfo(description, navigation);
  }
}
