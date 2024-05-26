part of '../usecases.dart';

class DeleteEmployerReviewsUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerDeleteReviewsRequestParams> {
  final EmployerRepository _employerRepository;
  DeleteEmployerReviewsUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerDeleteReviewsRequestParams? params}) {
    return _employerRepository.deleteEmployerReview(params!);
  }
}
