import 'branch_info.dart';

class BranchLocator {
  final BranchInfo branchInfo;

  final double distance;

  BranchLocator(this.branchInfo, this.distance);

  @override
  String toString() {
    return 'BranchLocator {'
        'branchInfo: $branchInfo, '
        'distance: $distance'
        '}';
  }
}
