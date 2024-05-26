part of '../usecases.dart';

class GetEmployerReferFriendUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerReferFriendRequestParams> {
  final EmployerRepository _employerRepository;
  GetEmployerReferFriendUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerReferFriendRequestParams? params}) {
    return _employerRepository.employerReferFriendList(params!);
  }
}
