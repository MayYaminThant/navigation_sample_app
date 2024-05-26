part of '../usecases.dart';

class GetConnectionListUseCase implements UseCase<DataState<DataResponseModel>, ConnectionListRequestParams> {
  final ConnectionRepository _connectionRepository;
  GetConnectionListUseCase(this._connectionRepository);

  @override
  Future<DataState<DataResponseModel>> call({ConnectionListRequestParams? params}) {
    return _connectionRepository.connectionList(params!);
  }
}
