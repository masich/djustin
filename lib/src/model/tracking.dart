class Tracking {
  final int orderNumber;
  final String orderDescription;

  // jsonName: date, time
  final DateTime dateTime;
  final String status;
  final String departmentNumber;
  final String departmentAddress;

  Tracking(this.orderNumber, this.orderDescription, this.dateTime, this.status,
      this.departmentNumber, this.departmentAddress);
}
