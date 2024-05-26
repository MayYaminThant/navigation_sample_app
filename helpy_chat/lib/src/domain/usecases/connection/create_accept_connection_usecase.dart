part of '../usecases.dart';

class CreateAcceptConnectionUseCase
    implements
        UseCase<DataState<DataResponseModel>,
            ConnectionAcceptRequestParams> {
  final ConnectionRepository _connectionRepository;
  CreateAcceptConnectionUseCase(this._connectionRepository);

  @override
  Future<DataState<DataResponseModel>> call(
      {ConnectionAcceptRequestParams? params}) {
    return _connectionRepository.createAcceptRequests(params!);
  }
}
