import 'package:djustin/converters.dart';
import 'package:djustin/djustin.dart';
import 'package:djustin/src/service/service.dart';
import 'package:http/http.dart' as http;

class Endpoint {
  static const String base = 'http://openapi.justin.ua';
  static const String branches = '/branches';
  static const String branchTypes = '/branch_types';
  static const String branchLocator = '/branches_locator';
  static const String tracking = '/tracking';
  static const String trackingHistory = '/tracking_history';
  static const String localities = '/localities';
  static const String servicesInfo = '/services';

  Endpoint._();
}

class JustinService extends Service {
  JustinService({String endpointBase = Endpoint.base, http.Client client})
      : super(endpointBase: endpointBase, client: client);

  Future<Response<BranchType>> getBranchTypes() {
    return getResponseDirect(Endpoint.branchTypes, BranchTypeConverter());
  }

  Future<Response<Tracking>> getTracking(String trackingNumber) {
    var endpoint = '${Endpoint.tracking}/${trackingNumber}';
    return getResponseDirect(endpoint, TrackingConverter());
  }

  Future<Response<Tracking>> getTrackingHistory(String trackingNumber) {
    var endpoint = '${Endpoint.trackingHistory}/${trackingNumber}';
    return getResponseDirect(endpoint, TrackingConverter());
  }

  Future<Response<Locality>> getLocalitiesAll() {
    return getResponseDirect(Endpoint.localities, LocalityConverter());
  }

  Future<Response<Locality>> getLocalitiesActive() {
    var endpoint = '${Endpoint.localities}/activity';
    return getResponseDirect(endpoint, LocalityConverter());
  }

  Future<Response<ServiceInfo>> getServicesInfo() {
    return getResponseDirect(Endpoint.servicesInfo, ServiceInfoConverter());
  }

  Future<Response<Branch>> getBranchesAll() {
    return getResponseDirect(Endpoint.branches, BranchConverter());
  }

  Future<Response<Branch>> getBranch(int branchNumber) {
    var endpoint = '${Endpoint.branches}/${branchNumber}';
    return getResponseDirect(endpoint, BranchConverter());
  }

  Future<Response<Branch>> getBranches(String forUrbanArea) {
    var endpoint = '${Endpoint.branches}?locality=${forUrbanArea}';
    return getResponseDirect(endpoint, BranchConverter());
  }

  Future<Response<BranchLocator>> getBranchLocators(String forAddress) {
    var endpoint = '${Endpoint.branchLocator}/${forAddress}';
    return getResponseDirect(endpoint, BranchLocatorConverter());
  }
}
