import 'package:djustin/converters.dart';
import 'package:djustin/djustin.dart';
import 'package:djustin/src/service/service.dart';
import 'package:http/http.dart' as http;

abstract class Endpoint {
  static const String base = 'http://openapi.justin.ua';
  static const String branches = '/branches';
  static const String branchTypes = '/branch_types';
  static const String branchLocator = '/branches_locator';
  static const String tracking = '/tracking';
  static const String trackingHistory = '/tracking_history';
  static const String localities = '/localities';
  static const String servicesInfo = '/services';
}

class JustinService extends Service {
  JustinService({String endpointBase = Endpoint.base, http.Client client})
      : super(endpointBase: endpointBase, client: client);

  Future<Response<BranchType>> getBranchTypes({OnErrorCallback onError}) {
    return getResponseDirect(Endpoint.branchTypes, BranchTypeConverter(),
        onError: onError);
  }

  Future<Response<Tracking>> getTracking(String trackCode,
      {OnErrorCallback onError}) {
    var endpoint = '${Endpoint.tracking}/${trackCode}';
    return getResponseDirect(endpoint, TrackingConverter(), onError: onError);
  }

  Future<Response<Tracking>> getTrackingHistory(String trackCode,
      {OnErrorCallback onError}) {
    var endpoint = '${Endpoint.trackingHistory}/${trackCode}';
    return getResponseDirect(endpoint, TrackingConverter(), onError: onError);
  }

  Future<Response<Locality>> getLocalitiesAll({OnErrorCallback onError}) {
    return getResponseDirect(Endpoint.localities, LocalityConverter(),
        onError: onError);
  }

  Future<Response<Locality>> getLocalitiesActive({OnErrorCallback onError}) {
    var endpoint = '${Endpoint.localities}/activity';
    return getResponseDirect(endpoint, LocalityConverter(), onError: onError);
  }

  Future<Response<ServiceInfo>> getServicesInfo({OnErrorCallback onError}) {
    return getResponseDirect(Endpoint.servicesInfo, ServiceInfoConverter(),
        onError: onError);
  }

  Future<Response<Branch>> getBranchesAll({OnErrorCallback onError}) {
    return getResponseDirect(Endpoint.branches, BranchConverter(),
        onError: onError);
  }

  Future<Response<Branch>> getBranch(int branchNumber,
      {OnErrorCallback onError}) {
    var endpoint = '${Endpoint.branches}/${branchNumber}';
    return getResponseDirect(endpoint, BranchConverter(), onError: onError);
  }

  Future<Response<Branch>> getBranches(String forUrbanArea,
      {OnErrorCallback onError}) {
    var endpoint = '${Endpoint.branches}?locality=${forUrbanArea}';
    return getResponseDirect(endpoint, BranchConverter(), onError: onError);
  }

  Future<Response<BranchLocator>> getBranchLocators(String forAddress,
      {OnErrorCallback onError}) {
    var endpoint = '${Endpoint.branchLocator}/${forAddress}';
    return getResponseDirect(endpoint, BranchLocatorConverter(),
        onError: onError);
  }
}
