import 'branch_format.dart';

class BranchInfo {
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

  BranchInfo(this.number, this.address, this.locality, this.type, this.format, this.deliveryBranchId, this.maxWeight,
      this.latitude, this.longitude, this.description, this.scheduleDescription);

  @override
  String toString() {
    return 'BranchInfo {'
        'number: $number, '
        'address: $address, '
        'locality: $locality, '
        'type: $type, '
        'format: ${format.string()}, '
        'deliveryBranchId: $deliveryBranchId, '
        'maxWeight: $maxWeight, '
        'latitude: $latitude, '
        'longitude: $longitude, '
        'description: $description, '
        'scheduleDescription: $scheduleDescription'
        '}';
  }
}
