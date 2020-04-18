import 'package:djustin/converters.dart';
import 'package:djustin/djustin.dart';
import 'package:djustin/src/service/service.dart';
import 'package:http/http.dart' as http;

import 'justin_endpoints.dart' as endpoints;

typedef OnErrorCallback = void Function(int status, ResponseMessage message);

class JustinService extends Service {
  JustinService(
      {String endpointBase = endpoints.justinBase, http.Client client})
      : super(endpointBase: endpointBase, client: client);

  Future<Response<BranchType>> getBranchTypesResponse(
      {OnHttpErrorCallback onHttpError}) {
    return getResponseDirect(endpoints.justinBranchTypes, BranchTypeConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<Tracking>> getTrackingResponse(String trackCode,
      {OnHttpErrorCallback onHttpError}) {
    var endpoint = '${endpoints.justinTracking}/${trackCode}';
    return getResponseDirect(endpoint, TrackingConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<Tracking>> getTrackingHistoryResponse(String trackCode,
      {OnHttpErrorCallback onHttpError}) {
    var endpoint = '${endpoints.justinTrackingHistory}/${trackCode}';
    return getResponseDirect(endpoint, TrackingConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<Locality>> getLocalitiesAllResponse(
      {OnHttpErrorCallback onHttpError}) {
    return getResponseDirect(endpoints.justinLocalities, LocalityConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<Locality>> getLocalitiesActiveResponse(
      {OnHttpErrorCallback onHttpError}) {
    var endpoint = '${endpoints.justinLocalities}/activity';
    return getResponseDirect(endpoint, LocalityConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<ServiceInfo>> getServicesInfoResponse(
      {OnHttpErrorCallback onHttpError}) {
    return getResponseDirect(
        endpoints.justinServicesInfo, ServiceInfoConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<Branch>> getBranchesAllResponse(
      {OnHttpErrorCallback onHttpError}) {
    return getResponseDirect(endpoints.justinBranches, BranchConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<Branch>> getBranchResponse(int branchNumber,
      {OnHttpErrorCallback onHttpError}) {
    var endpoint = '${endpoints.justinBranches}/${branchNumber}';
    return getResponseDirect(endpoint, BranchConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<Branch>> getBranchesResponse(String forUrbanArea,
      {OnHttpErrorCallback onHttpError}) {
    var endpoint = '${endpoints.justinBranches}?locality=${forUrbanArea}';
    return getResponseDirect(endpoint, BranchConverter(),
        onHttpError: onHttpError);
  }

  Future<Response<BranchLocator>> getBranchLocatorsResponse(String forAddress,
      {OnHttpErrorCallback onHttpError}) {
    var endpoint = '${endpoints.justinBranchLocator}/${forAddress}';
    return getResponseDirect(endpoint, BranchLocatorConverter(),
        onHttpError: onHttpError);
  }

  Future<List<BranchType>> getBranchTypes(
      {OnErrorCallback onError, OnHttpErrorCallback onHttpError}) async {
    var response = await getBranchTypesResponse(onHttpError: onHttpError);
    return processResponse(response, onError: onError);
  }

  Future<Tracking> getTracking(String trackCode,
      {OnErrorCallback onError, OnHttpErrorCallback onHttpError}) async {
    var response =
        await getTrackingResponse(trackCode, onHttpError: onHttpError);
    var results = processResponse(response, onError: onError) ?? [];
    return results.isEmpty ? null : results.first;
  }

  Future<List<Tracking>> getTrackingHistory(String trackCode,
      {OnErrorCallback onError, OnHttpErrorCallback onHttpError}) async {
    var response =
        await getTrackingHistoryResponse(trackCode, onHttpError: onHttpError);
    return processResponse(response, onError: onError);
  }

  Future<List<Locality>> getLocalitiesAll(
      {OnErrorCallback onError, OnHttpErrorCallback onHttpError}) async {
    var response = await getLocalitiesActiveResponse(onHttpError: onHttpError);
    return processResponse(response, onError: onError);
  }

  Future<List<Locality>> getLocalitiesActive(
      {OnErrorCallback onError, OnHttpErrorCallback onHttpError}) async {
    var response = await getLocalitiesActiveResponse(onHttpError: onHttpError);
    return processResponse(response, onError: onError);
  }

  Future<List<ServiceInfo>> getServicesInfo(
      {OnErrorCallback onError, OnHttpErrorCallback onHttpError}) async {
    var response = await getServicesInfoResponse(onHttpError: onHttpError);
    return processResponse(response, onError: onError);
  }

  Future<List<Branch>> getBranchesAll(
      {OnErrorCallback onError, OnHttpErrorCallback onHttpError}) async {
    var response = await getBranchesAllResponse(onHttpError: onHttpError);
    return processResponse(response, onError: onError);
  }

  Future<Branch> getBranch(int branchNumber,
      {OnErrorCallback onError, OnHttpErrorCallback onHttpError}) async {
    var response =
        await getBranchResponse(branchNumber, onHttpError: onHttpError);
    var results = processResponse(response, onError: onError) ?? [];
    return results.isEmpty ? null : results.first;
  }

  Future<List<Branch>> getBranches(String forUrbanArea,
      {OnErrorCallback onError, OnHttpErrorCallback onHttpError}) async {
    var response =
        await getBranchesResponse(forUrbanArea, onHttpError: onHttpError);
    return processResponse(response, onError: onError);
  }

  Future<List<BranchLocator>> getBranchLocators(String forAddress,
      {OnErrorCallback onError, OnHttpErrorCallback onHttpError}) async {
    var response =
        await getBranchLocatorsResponse(forAddress, onHttpError: onHttpError);
    return processResponse(response, onError: onError);
  }

  List<ResultType> processResponse<ResultType>(Response<ResultType> response,
      {OnErrorCallback onError}) {
    List<ResultType> results;
    if (response.status == Response.statusOk) {
      results = response.results;
    } else {
      onError ??= _defaultErrorHandler;
      onError(response.status, response.message);
    }
    return results;
  }

  static void _defaultErrorHandler(int status, ResponseMessage message) {
    print(
        "Justin response contains an error. Status: '$status'; Message: '$message'");
  }
}
