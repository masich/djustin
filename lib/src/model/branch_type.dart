import 'branch_format.dart';

class BranchType {
  // jsonName: 'short_name'
  final BranchFormat format;

  final String description;

  BranchType(this.format, this.description);

  @override
  String toString() {
    return 'BranchType { '
        'format: ${format.string()}, '
        'description: $description '
        '}';
  }
}
