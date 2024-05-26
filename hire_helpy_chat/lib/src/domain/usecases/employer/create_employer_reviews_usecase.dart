part of '../usecases.dart';

class CreateEmployerReviewsUseCase
    implements UseCase<DataState<DataResponseModel>, EmployerCreateReviewsRequestParams> {
  final EmployerRepository _employerRepository;
  CreateEmployerReviewsUseCase(this._employerRepository);

  @override
  Future<DataState<DataResponseModel>> call({EmployerCreateReviewsRequestParams? params}) {
    return _employerRepository.createEmployerReview(params!);
  }
}
