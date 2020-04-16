class Tracking {
  final int orderNumber;
  final String orderDescription;

  // jsonName: date, time
  final DateTime dateTime;
  final String status;
  final String departmentNumber;
  final String departmentAddress;

  Tracking(this.orderNumber, this.orderDescription, this.dateTime, this.status, this.departmentNumber,
      this.departmentAddress);

  @override
  String toString() {
    return 'Tracking {'
        'orderNumber: $orderNumber, '
        'orderDescription: $orderDescription, '
        'dateTime: $dateTime, '
        'status: $status, '
        'departmentNumber: $departmentNumber, '
        'departmentAddress: $departmentAddress'
        '}';
  }
}
