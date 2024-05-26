library usecases;

import 'package:dh_mobile/src/core/params/params.dart';
import 'package:dh_mobile/src/domain/repositories/repositories.dart';
import '../../core/resources/data_state.dart';
import '../../core/usecases/usecase.dart';
import '../../data/models/models.dart';

//Candidate
part 'candidate/create_candidate_login_usecase.dart';
part 'candidate/create_candidate_social_login_usecase.dart';
part 'candidate/create_candidate_register_usecase.dart';
part 'candidate/create_candidate_social_register_usecase.dart';
part 'candidate/create_candidate_contact_us_usecase.dart';
part 'candidate/get_candidate_logout_usecase.dart';
part 'candidate/get_candidate_configs_usecase.dart';
part 'candidate/get_candidate_countries_usecase.dart';
part 'candidate/get_candidate_genders_usecase.dart';
part 'candidate/get_candidate_langauge_types_usecase.dart';
part 'candidate/get_candidate_religions_usecase.dart';
part 'candidate/get_candidate_profile_usecase.dart';
part 'candidate/create_candidate_portfolio_usecase.dart';
part 'candidate/delete_candidate_portfolio_usecase.dart';
part 'candidate/create_candidate_about_usecase.dart';
part 'candidate/update_candidate_family_information_usecase.dart';
part 'candidate/update_candidate_skill_usecase.dart';
part 'candidate/get_candidate_employments_usecase.dart';
part 'candidate/create_candidate_employments_usecase.dart';
part 'candidate/update_candidate_employment_usecase.dart';
part 'candidate/delete_candidate_employment_usecase.dart';
part 'candidate/get_candidate_availability_usecase.dart';
part 'candidate/update_candidate_availability_usecase.dart';
part 'candidate/get_candidate_star_list_usecase.dart';
part 'candidate/create_candidate_star_list_usecase.dart';
part 'candidate/remove_candidate_star_list_usecase.dart';
part 'candidate/create_candidate_forgot_password_usecase.dart';
part 'candidate/create_candidate_reset_password_usecase.dart';
part 'candidate/create_candidate_spotlights_usecase.dart';
part 'candidate/update_candidate_working_preferences_usecase.dart';
part 'candidate/update_candidate_fcm_usecase.dart';
part 'candidate/get_candidate_save_search_usecase.dart';
part 'candidate/update_candidate_save_search_usecase.dart';
part 'candidate/delete_candidate_save_search_usecase.dart';
part 'candidate/create_candidate_verification_usecase.dart';
part 'candidate/create_candidate_review_usecase.dart';
part 'candidate/create_candidate_bigdata_usecase.dart';
part 'candidate/delete_candidate_bigdata_usecase.dart';
part 'candidate/delete_candidate_account_usecase.dart';
part 'candidate/delete_candidate_profile_usecase.dart';
part 'candidate/delete_candidate_review_usecase.dart';
part 'candidate/get_candidate_reviews_usecase.dart';
part 'candidate/get_candidate_coin_history_usecase.dart';
part 'candidate/get_candidate_coin_balance_usecase.dart';
part 'candidate/get_candidate_refer_friend_usecase.dart';
part 'candidate/update_candidate_account_usecase.dart';
part 'candidate/create_candidate_employment_sort_usecase.dart';
part 'candidate/update_candidate_save_search_notify_usecase.dart';
part 'candidate/update_candidate_shareablelink_usecase.dart';
part 'candidate/get_candidate_check_verified_usecase.dart';
part 'candidate/create_candidate_workpermit_usecase.dart';
part 'candidate/create_candidate_complaint_usecase.dart';
part 'candidate/update_candidate_configs_usecase.dart';
part 'candidate/create_candidate_exchange_usecase.dart';
part 'candidate/create_candidate_offer_action_usecase.dart';

//Article
part 'article/get_article_list_usecase.dart';
part 'article/create_article_usecase.dart';
part 'article/get_article_comment_usecase.dart';
part 'article/create_article_comment_usecase.dart';
part 'article/update_article_comment_usecase.dart';
part 'article/reply_article_comment_usecase.dart';
part 'article/delete_article_comment_usecase.dart';
part 'article/create_upvote_article_usecase.dart';
part 'article/create_downvote_article_usecase.dart';
part 'article/get_new_list_usecase.dart';
part 'article/create_article_complain_usecase.dart';
part 'article/create_comment_complain_usecase.dart';
part 'article/get_article_detail_usecase.dart';
part 'article/get_new_detail_usecase.dart';
part 'article/delete_article_usecase.dart';
part 'article/update_article_usecase.dart';

//Employer
part 'employer/create_employer_search_usecase.dart';
part 'employer/get_employer_profile_usecase.dart';

//Notification
part 'notification/get_notification_usecase.dart';
part 'notification/create_notification_read_usecase.dart';
part 'notification/create_notification_unread_usecase.dart';
part 'notification/delete_notification_usecase.dart';
part 'notification/delete_all_notifications_usecase.dart';

//Connection
part 'connection/create_send_connection_usecase.dart';
part 'connection/create_accept_connection_usecase.dart';
part 'connection/create_reject_connection_usecase.dart';
part 'connection/get_incoming_connection_usecase.dart';
part 'connection/get_my_connection_usecase.dart';
part 'connection/delete_my_connection_usecase.dart';
part 'connection/get_connection_list_usecase.dart';
part 'connection/delete_connection_link_usecase.dart';

//Ads
part 'ads/get_ads_list_usecase.dart';

//ads count
part "ads/ads_count_usecase.dart";

//Faq
part 'faq/get_faq_usecase.dart';

//Reward
part 'reward/get_claim_reward_usecase.dart';
part 'reward/get_rewards_list_usecase.dart';
