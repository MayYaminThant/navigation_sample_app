part of '../usecases.dart';

class CreateSendConnectionUseCase
    implements
        UseCase<DataState<DataResponseModel>,
            ConnectionSendRequestParams> {
  final ConnectionRepository _connectionRepository;
  CreateSendConnectionUseCase(this._connectionRepository);

  @override
  Future<DataState<DataResponseModel>> call(
      {ConnectionSendRequestParams? params}) {
    return _connectionRepository.createSendRequest(params!);
  }
}
