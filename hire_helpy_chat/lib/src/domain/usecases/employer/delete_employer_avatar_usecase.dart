part of '../usecases.dart';

class DeleteEmployerAvatarUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerDeleteAvatarRequestParams> {
  final EmployerRepository _employerRepository;
  DeleteEmployerAvatarUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerDeleteAvatarRequestParams? params}) {
    return _employerRepository.deleteEmployerAvatar(params!);
  }
}
