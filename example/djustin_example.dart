import 'package:djustin/djustin.dart';

void main() async {
  // Initiate Service for Justin OpenAPI
  var service = JustinService();

  await printTracking(service, '201810165');
  // Will print:
  // Tracking {
  // orderNumber: 201810165,
  // orderDescription: Замовлення клієнта 201810165 від 7/25/2018,
  // dateTime: 2019-02-27 10:20:51.000,
  // status: Одержано,
  // departmentNumber: ,
  // departmentAddress:
  // }

  await printBranch(service, 2);
  // Will print info about branch number 2

  await printBranch(service, 999);
  // Will print:
  // Branch with the specified number not found

  await printAllBranches(service);
  // Will print info about all branches

  service.close();
}

/// Simple example that prints tracking info form Justin OpenAPI
/// for a given `trackingNumber`
void printBranch(JustinService service, int branchNumber) async {
  // Request info about branch with a `branchNumber` number
  var branchResponse = await service.getBranchResponse(branchNumber);
  if (branchResponse.status != Response.statusOk) {
    // If error occurs (ex. if there is no branch info for provided `branchNumber`
    print(branchResponse.message.text[Language.EN]);
  } else {
    // Take a tracking info from the response
    var tracking = branchResponse.results.first;
    print(tracking);
  }
}

/// Simple example that prints tracking info form Justin OpenAPI
/// for a given `trackingNumber`
void printTracking(JustinService service, String trackingNumber) async {
  // Make a request for a tracking info
  var trackingResponse = await service.getTrackingResponse(trackingNumber);
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
  var allBranchesResponse = await service.getBranchesAllResponse();
  // Take a result list from the response
  var allBranches = allBranchesResponse.results;
  print(allBranches);
}
