library blocs;

import 'dart:convert';

import 'package:dh_employer/src/data/models/article_model.dart';
import 'package:dh_employer/src/data/models/faq_data_model.dart';
import 'package:equatable/equatable.dart';
import '../../core/bloc/bloc_with_state.dart';
import '../../core/params/params.dart';
import '../../core/resources/data_state.dart';
import '../../data/models/models.dart';
import '../../data/models/faq_data_model.dart' as faqModel;
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

//Ads
part 'ads/ads_bloc.dart';
part 'ads/ads_state.dart';
part 'ads/ads_event.dart';

//Article
part 'article/article_bloc.dart';
part 'article/article_state.dart';
part 'article/article_event.dart';

//Connection
part 'candidate/candidate_bloc.dart';
part 'candidate/candidate_state.dart';
part 'candidate/candidate_event.dart';

//Connection
part 'connection/connection_bloc.dart';
part 'connection/connection_state.dart';
part 'connection/connection_event.dart';

//Employer
part 'employer/employer_bloc.dart';
part 'employer/employer_state.dart';
part 'employer/employer_event.dart';

//Faq
part 'faq/faq_bloc.dart';
part 'faq/faq_state.dart';
part 'faq/faq_event.dart';

//Notification
part 'notification/notification_bloc.dart';
part 'notification/notification_state.dart';
part 'notification/notification_event.dart';

//Rewards
part 'reward/reward_bloc.dart';
part 'reward/reward_state.dart';
part 'reward/reward_event.dart';
