part of '../usecases.dart';

class CreateEmployerAvatarUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerCreateAvatarRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerAvatarUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerCreateAvatarRequestParams? params}) {
    return _employerRepository.createEmployerAvatar(params!);
  }
}
