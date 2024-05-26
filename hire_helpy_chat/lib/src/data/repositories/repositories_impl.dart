library repostories_impl;

import 'package:dh_employer/src/core/params/params.dart';
import 'package:dh_employer/src/core/resources/data_state.dart';
import 'package:dh_employer/src/data/datasources/remote/article_api_service.dart';
import 'package:dh_employer/src/data/models/models.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/generate_thumbnails.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/remote/ads_api_service.dart';
import '../datasources/remote/candidate_api_service.dart';
import '../datasources/remote/connection_api_service.dart';
import '../datasources/remote/employer_api_service.dart';
import '../datasources/remote/faq_api_service.dart';
import '../datasources/remote/notification_api_service.dart';
import '../datasources/remote/rewards_api_service.dart';

part 'ads_repository_impl.dart';
part 'article_repository_impl.dart';
part 'candidate_repository_impl.dart';
part 'connection_repository_impl.dart';
part 'employer_repository_impl.dart';
part 'faq_repository_impl.dart';
part 'notification_repository_impl.dart';
part 'rewards_repository_impl.dart';
