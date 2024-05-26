part of '../usecases.dart';

class GetEmployerCoinBalanceUseCase
    implements
        UseCase<DataState<DataResponseModel>,
            EmployerCoinBalanceRequestParams> {
  final EmployerRepository _employerRepository;
  GetEmployerCoinBalanceUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call(
      {EmployerCoinBalanceRequestParams? params}) {
    return _employerRepository.employerCoinBalance(params!);
  }
}
