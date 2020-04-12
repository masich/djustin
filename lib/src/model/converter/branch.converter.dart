import 'package:djustin/src/model/common/json_converter.dart';
import 'package:djustin/src/model/common/locale.dart';

import 'package:djustin/src/model/branch.dart';
import 'package:djustin/src/model/branch_format.dart';

class BranchConverter extends JsonConverter<Branch> {
  PublicInfoConverter _infoConverter;

  static List<Uri> _parsePhotosUrls(List<dynamic> photosUrls) {
    return photosUrls?.map((e) => Uri.parse(e as String))?.toList();
  }

  static const int _serviceAvailable = 1;

  static Map<String, bool> _parseServices(Map<String, dynamic> services) {
    return services
        ?.map((k, e) => MapEntry(k, (e as int) == _serviceAvailable));
  }

  @override
  Branch fromJson(Map<String, dynamic> json) {
    Branch branch;
    if (json != null) {
      _infoConverter ??= PublicInfoConverter();
      branch = Branch(
          int.parse(json['number']),
          json['adress'],
          json['locality'],
          json['type'],
          BranchFormatExtension.fromString(json['format']),
          json['delivery_branch_id'],
          int.parse(json['max_weight']),
          json['lat'],
          json['lng'],
          json['description'],
          json['shedule_description'],
          _parsePhotosUrls(json['photos'] as List<dynamic>),
          _parseServices(json['services'] as Map<String, dynamic>),
          _infoConverter.fromJson(json['public']));
    }
    return branch;
  }

  @override
  Map<String, dynamic> toJson(Branch value) {
    // TODO: implement toJson
    throw UnimplementedError();
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

  @override
  Map<String, dynamic> toJson(PublicInfo value) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
