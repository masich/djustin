import 'package:djustin/djustin.dart';

void main() {
  // Initiate Service for Justin OpenAPI
  var service = JustinService();

  printTracking(service, '201810165');
  // Will print:
  // Tracking {
  // orderNumber: 201810165,
  // orderDescription: Замовлення клієнта 201810165 від 7/25/2018,
  // dateTime: 2019-02-27 10:20:51.000,
  // status: Одержано,
  // departmentNumber: ,
  // departmentAddress:
  // }

  printTracking(service, '000000000');
  // Will print:
  // Could not find the shipment

  printAllBranches(service);
}

/// Simple example that prints tracking info form Justin OpenAPI
/// for a given `trackingNumber`
void printTracking(JustinService service, String trackingNumber) async {
  // Make a request for a tracking info
  var trackingResponse = await service.getTracking(trackingNumber);
  if (trackingResponse.status != Response.statusOk) {
    // If error occurs (ex. if there is no tracking info for provided `trackingNumber`
    print(trackingResponse.message.text[Language.EN]);
  } else {
    // Take a tracking info from the response
    var tracking = trackingResponse.results.first;
    print(tracking);
  }
}

/// Simple example that prints all branches from Justin OpenAPI
void printAllBranches(JustinService service) async {
  // Make a request for all Justin branches
  var allBranchesResponse = await service.getBranchesAll();
  // Take a result list from the response
  var allBranches = allBranchesResponse.results;
  print(allBranches);
}
