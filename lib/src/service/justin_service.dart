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
  JustinService({String endpointBase, http.Client client})
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
}
