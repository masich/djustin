import 'package:djustin/src/model/branch_info.dart';

import 'common/locale.dart';

class Branch {
  final BranchInfo branchInfo;

  final List<Uri> photos;

  // jsonName: 'services'
  final Map<String, bool> servicesAvailability;

  // jsonName: 'public'
  final PublicInfo publicInfo;

  Branch(
      this.branchInfo, this.photos, this.servicesAvailability, this.publicInfo);

  @override
  String toString() {
    return 'Branch {'
        'branchInfo: $branchInfo, '
        'photos: $photos, '
        'servicesAvailability: $servicesAvailability, '
        'publicInfo: $publicInfo'
        '}';
  }
}

class PublicInfo {
  // jsonName: public_description_ru, public_description_ua, public_description_en
  final Map<Language, String> description;

  // jsonName: navigation_ru, navigation_ua, navigation_en
  final Map<Language, String> navigation;

  PublicInfo(this.description, this.navigation);

  @override
  String toString() {
    return 'PublicInfo {'
        'description: $description, '
        'navigation: $navigation'
        '}';
  }
}
