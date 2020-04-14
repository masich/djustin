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
    return services
        ?.map((k, e) => MapEntry(k, (e as int) == _serviceAvailable));
  }

  @override
  Branch fromJson(Map<String, dynamic> json) {
    Branch branch;
    if (json != null) {
      _infoConverter ??= PublicInfoConverter();
      _branchInfoConverter ??= BranchInfoConverter();
      branch = Branch(
          _branchInfoConverter.fromJson(json),
          _parsePhotosUrls(json['photos'] as List<dynamic>),
          _parseServices(json['services'] as Map<String, dynamic>),
          _infoConverter.fromJson(json['public']));
    }
    return branch;
  }
}

class PublicInfoConverter extends JsonConverter<PublicInfo> {
  @override
  PublicInfo fromJson(Map<String, dynamic> json) {
    PublicInfo publicInfo;
    if (json != null) {
      var description = <Language, String>{
        Language.UA: json['public_description_ua'],
        Language.EN: json['public_description_en'],
        Language.RU: json['public_description_ru']
      };
      var navigation = <Language, String>{
        Language.UA: json['navigation_ua'],
        Language.EN: json['navigation_en'],
        Language.RU: json['navigation_ru']
      };
      publicInfo = PublicInfo(description, navigation);
    }
    return publicInfo;
  }
}
