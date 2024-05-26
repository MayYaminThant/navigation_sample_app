part of '../usecases.dart';

class GetEmployerReviewsUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerReviewsRequestParams> {
  final EmployerRepository _employerRepository;
  GetEmployerReviewsUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerReviewsRequestParams? params}) {
    return _employerRepository.getEmployerReviews(params!);
  }
}
