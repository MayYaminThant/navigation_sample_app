part of '../usecases.dart';

class DeleteConnectionLinkUseCase implements UseCase<DataState<DataResponseModel>, ConnectionUnlinkRequestParams> {
  final ConnectionRepository _connectionRepository;
  DeleteConnectionLinkUseCase(this._connectionRepository);

  @override
  Future<DataState<DataResponseModel>> call({ConnectionUnlinkRequestParams? params}) {
    return _connectionRepository.connectionUnlink(params!);
  }
}
