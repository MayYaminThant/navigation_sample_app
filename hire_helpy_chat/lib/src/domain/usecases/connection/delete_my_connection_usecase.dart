part of '../usecases.dart';

class DeleteMyConnectionRequestUseCase
    implements
        UseCase<DataState<DataResponseModel>,
            ConnectionCancelRequestParams> {
  final ConnectionRepository _connectionRepository;
  DeleteMyConnectionRequestUseCase(this._connectionRepository);

  @override
  Future<DataState<DataResponseModel>> call(
      {ConnectionCancelRequestParams? params}) {
    return _connectionRepository.deleteMyRequests(params!);
  }
}
