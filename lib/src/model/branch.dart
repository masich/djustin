import 'branch_format.dart';
import 'common/locale.dart';

class Branch {
  final int number;
  final String address;
  final String locality;
  final String type;
  final BranchFormat format;

  // jsonName: 'delivery_branch_id'
  final String deliveryBranchId;

  // jsonName: 'max_weight'
  final int maxWeight;

  // jsonName: 'lat'
  final String latitude;

  // jsonName: 'lng'
  final String longitude;

  final String description;

  // jsonName: 'shedule_description'
  final String scheduleDescription;

  final List<Uri> photos;

  // jsonName: 'services'
  final Map<String, bool> servicesAvailability;

  // jsonName: 'public'
  final PublicInfo publicInfo;

  Branch(
      this.number,
      this.address,
      this.locality,
      this.type,
      this.format,
      this.deliveryBranchId,
      this.maxWeight,
      this.latitude,
      this.longitude,
      this.description,
      this.scheduleDescription,
      this.photos,
      this.servicesAvailability,
      this.publicInfo);

  @override
  String toString() {
    return 'Branch { '
        'number: $number, '
        'address: $address, '
        'locality: $locality, '
        'type: $type, '
        'format: $format, '
        'deliveryBranchId: $deliveryBranchId, '
        'maxWeight: $maxWeight, '
        'latitude: $latitude, '
        'longitude: $longitude, '
        'description: $description, '
        'scheduleDescription: $scheduleDescription, '
        'photos: $photos, '
        'servicesAvailability: $servicesAvailability, '
        'publicInfo: $publicInfo '
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
        'navigation: $navigation '
        '}';
  }
}
