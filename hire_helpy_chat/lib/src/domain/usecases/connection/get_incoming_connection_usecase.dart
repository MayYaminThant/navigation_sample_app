part of '../usecases.dart';

class GetIncomingConnectionRequestUseCase
    implements
        UseCase<DataState<DataResponseModel>,
            ConnectionIncomingRequestParams> {
  final ConnectionRepository _connectionRepository;
  GetIncomingConnectionRequestUseCase(this._connectionRepository);

  @override
  Future<DataState<DataResponseModel>> call(
      {ConnectionIncomingRequestParams? params}) {
    return _connectionRepository.getIncomingRequests(params!);
  }
}
