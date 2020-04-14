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

  Future<Response<BranchType>> getBranchTypesResponse(
      {OnHttpErrorCallback onHttpError}) {
    return getResponseDirect(Endpoint.branchTypes, BranchTypeConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<Tracking>> getTrackingResponse(String trackCode,
      {OnHttpErrorCallback onHttpError}) {
    var endpoint = '${Endpoint.tracking}/${trackCode}';
    return getResponseDirect(endpoint, TrackingConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<Tracking>> getTrackingHistoryResponse(String trackCode,
      {OnHttpErrorCallback onHttpError}) {
    var endpoint = '${Endpoint.trackingHistory}/${trackCode}';
    return getResponseDirect(endpoint, TrackingConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<Locality>> getLocalitiesAllResponse(
      {OnHttpErrorCallback onHttpError}) {
    return getResponseDirect(Endpoint.localities, LocalityConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<Locality>> getLocalitiesActiveResponse(
      {OnHttpErrorCallback onHttpError}) {
    var endpoint = '${Endpoint.localities}/activity';
    return getResponseDirect(endpoint, LocalityConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<ServiceInfo>> getServicesInfoResponse(
      {OnHttpErrorCallback onHttpError}) {
    return getResponseDirect(Endpoint.servicesInfo, ServiceInfoConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<Branch>> getBranchesAllResponse(
      {OnHttpErrorCallback onHttpError}) {
    return getResponseDirect(Endpoint.branches, BranchConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<Branch>> getBranchResponse(int branchNumber,
      {OnHttpErrorCallback onHttpError}) {
    var endpoint = '${Endpoint.branches}/${branchNumber}';
    return getResponseDirect(endpoint, BranchConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<Branch>> getBranchesResponse(String forUrbanArea,
      {OnHttpErrorCallback onHttpError}) {
    var endpoint = '${Endpoint.branches}?locality=${forUrbanArea}';
    return getResponseDirect(endpoint, BranchConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<BranchLocator>> getBranchLocatorsResponse(String forAddress,
      {OnHttpErrorCallback onHttpError}) {
    var endpoint = '${Endpoint.branchLocator}/${forAddress}';
    return getResponseDirect(endpoint, BranchLocatorConverter(),
        onHttpError: onHttpError);
  }
}
