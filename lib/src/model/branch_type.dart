import 'branch_format.dart';
import 'common/json_converter.dart';

part 'branch_type.converter.dart';

class BranchType {
  // jsonName: 'short_name'
  final BranchFormat format;

  final String description;

  BranchType(this.format, this.description);
}
