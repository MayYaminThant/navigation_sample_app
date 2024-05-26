part of 'repositories.dart';

abstract class ConnectionRepository {

  //Connection Create Send Request
  Future<DataState<DataResponseModel>> createSendRequest(
      ConnectionSendRequestParams params);

  //Connection My Request
  Future<DataState<DataResponseModel>> getMyRequests(
      ConnectionGetMyRequestParams params);

  //Connection Incoming Request
  Future<DataState<DataResponseModel>> getIncomingRequests(
      ConnectionIncomingRequestParams params);
  
  //Connection Accept Request
  Future<DataState<DataResponseModel>> createAcceptRequests(
      ConnectionAcceptRequestParams params);

  //Connection Reject Request
  Future<DataState<DataResponseModel>> createRejectRequests(
      ConnectionRejectRequestParams params);

  //Connection Delete My Request
  Future<DataState<DataResponseModel>> deleteMyRequests(
      ConnectionCancelRequestParams params);
      
 //Connection List
  Future<DataState<DataResponseModel>> connectionList(
      ConnectionListRequestParams params);

//Connection Unlink
  Future<DataState<DataResponseModel>> connectionUnlink(
      ConnectionUnlinkRequestParams params);

}
