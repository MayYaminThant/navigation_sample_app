part of '../usecases.dart';

class DeleteEmployerOfferUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerDeleteOfferRequestParams> {
  final EmployerRepository _employerRepository;
  DeleteEmployerOfferUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerDeleteOfferRequestParams? params}) {
    return _employerRepository.deleteEmployerBigData(params!);
  }
}
