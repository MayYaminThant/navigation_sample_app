part of '../usecases.dart';

class GetMyConnectionRequestUseCase
    implements
        UseCase<DataState<DataResponseModel>,
            ConnectionGetMyRequestParams> {
  final ConnectionRepository _connectionRepository;
  GetMyConnectionRequestUseCase(this._connectionRepository);

  @override
  Future<DataState<DataResponseModel>> call(
      {ConnectionGetMyRequestParams? params}) {
    return _connectionRepository.getMyRequests(params!);
  }
}
