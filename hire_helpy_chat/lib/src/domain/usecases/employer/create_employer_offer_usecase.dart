part of '../usecases.dart';

class CreateEmployerOfferUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerCreateOfferRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerOfferUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerCreateOfferRequestParams? params}) {
    return _employerRepository.createEmployerBigData(params!);
  }
}
