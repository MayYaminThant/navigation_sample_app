part of '../usecases.dart';

class GetEmployerCoinHistoryUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerListVoucherHistoryRequestParams> {
  final EmployerRepository _employerRepository;
  GetEmployerCoinHistoryUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerListVoucherHistoryRequestParams? params}) {
    return _employerRepository.employerCoinListHistory(params!);
  }
}
