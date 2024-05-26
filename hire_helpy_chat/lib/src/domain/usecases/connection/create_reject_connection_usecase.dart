part of '../usecases.dart';

class CreateRejectConnectionUseCase
    implements
        UseCase<DataState<DataResponseModel>,
            ConnectionRejectRequestParams> {
  final ConnectionRepository _connectionRepository;
  CreateRejectConnectionUseCase(this._connectionRepository);

  @override
  Future<DataState<DataResponseModel>> call(
      {ConnectionRejectRequestParams? params}) {
    return _connectionRepository.createRejectRequests(params!);
  }
}
