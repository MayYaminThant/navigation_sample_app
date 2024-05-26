part of 'repositories.dart';

abstract class EmployerRepository {
  //Employer Search Create
  Future<DataState<DataResponseModel>> employerSearch(
      EmployerSearchCreateRequestParams params);
  
  //Employer Public Profile
  Future<DataState<DataResponseModel>> employerPublicProfile(
      EmployerPublicProfileRequestParams params);
}
