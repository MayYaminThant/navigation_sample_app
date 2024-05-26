library usecases;

import 'package:dh_employer/src/core/params/params.dart';
import 'package:dh_employer/src/domain/repositories/repositories.dart';

import '../../core/resources/data_state.dart';
import '../../core/usecases/usecase.dart';
import '../../data/models/models.dart';

//Ads
part 'ads/get_ads_list_usecase.dart';
part 'article/create_article_comment_usecase.dart';
part 'article/create_article_complain_usecase.dart';
part 'article/create_article_usecase.dart';
part 'article/create_comment_complain_usecase.dart';
part 'article/create_downvote_article_usecase.dart';
part 'article/create_upvote_article_usecase.dart';
part 'article/delete_article_comment_usecase.dart';
part 'article/delete_article_usecase.dart';
part 'article/get_article_comment_usecase.dart';
part 'article/get_article_detail_usecase.dart';
//Article
part 'article/get_article_list_usecase.dart';
part 'article/get_new_detail_usecase.dart';
part 'article/get_new_list_usecase.dart';
part 'article/reply_article_comment_usecase.dart';
part 'article/update_article_comment_usecase.dart';
part 'article/update_article_usecase.dart';
//Candidate
part 'candidate/create_candidate_search_usecase.dart';
part 'candidate/get_candidate_profile_usecase.dart';
part 'connection/create_accept_connection_usecase.dart';
part 'connection/create_reject_connection_usecase.dart';
//Connection
part 'connection/create_send_connection_usecase.dart';
part 'connection/delete_connection_link_usecase.dart';
part 'connection/delete_my_connection_usecase.dart';
part 'connection/get_connection_list_usecase.dart';
part 'connection/get_incoming_connection_usecase.dart';
part 'connection/get_my_connection_usecase.dart';
part 'employer/create_employer_about_usecase.dart';
part 'employer/create_employer_avatar_usecase.dart';
part 'employer/create_employer_complaint_usecase.dart';
part 'employer/create_employer_contact_us_usecase.dart';
part 'employer/create_employer_exchange_usecase.dart';
part 'employer/create_employer_forgot_password_usecase.dart';
//Employer
part 'employer/create_employer_login_usecase.dart';
part 'employer/create_employer_offer_usecase.dart';
part 'employer/create_employer_register_usecase.dart';
part 'employer/create_employer_reset_password_usecase.dart';
part 'employer/create_employer_reviews_usecase.dart';
part 'employer/create_employer_social_login_usecase.dart';
part 'employer/create_employer_social_register_usecase.dart';
part 'employer/create_employer_spotlights_usecase.dart';
part 'employer/create_employer_star_list_usecase.dart';
part 'employer/create_employer_verification_usecase.dart';
part 'employer/create_hiring_usecase.dart';
part 'employer/delete_employer_account_usecase.dart';
part 'employer/delete_employer_avatar_usecase.dart';
part 'employer/delete_employer_offer_usecase.dart';
part 'employer/delete_employer_profile_usecase.dart';
part 'employer/delete_employer_reviews_usecase.dart';
part 'employer/delete_employer_save_search_usecase.dart';
part 'employer/delete_employer_star_list_usecase.dart';
part 'employer/get_candidate_save_search_usecase.dart';
part 'employer/get_candidate_star_list_usecase.dart';
part 'employer/get_employer_availability_usecase.dart';
part 'employer/get_employer_check_verified_usecase.dart';
part 'employer/get_employer_coin_balance_usecase.dart';
part 'employer/get_employer_configs_usecase.dart';
part 'employer/get_employer_logout_usecase.dart';
part 'employer/get_employer_profile_usecase.dart';
part 'employer/get_employer_refer_friend_usecase.dart';
part 'employer/get_employer_reviews_usecase.dart';
part 'employer/get_employer_voucher_history_usecase.dart';
part 'employer/update_employer_account_usecase.dart';
part 'employer/update_employer_availability_usecase.dart';
part 'employer/update_employer_configs_usecase.dart';
part 'employer/update_employer_family_information_usecase.dart';
part 'employer/update_employer_fcm_usecase.dart';
part 'employer/update_employer_language_usecase.dart';
part 'employer/update_employer_save_search_notify_usecase.dart';
part 'employer/update_employer_save_search_usecase.dart';
part 'employer/update_employer_shareablelink_usecase.dart';
part 'employer/update_employer_working_preferences_usecase.dart';
//Faq
part 'faq/get_faq_usecase.dart';
part 'notification/create_notification_read_usecase.dart';
part 'notification/create_notification_unread_usecase.dart';
part 'notification/delete_all_notifications_usecase.dart';
part 'notification/delete_notification_usecase.dart';
//Notification
part 'notification/get_notification_usecase.dart';
//Reward
part 'reward/get_claim_reward_usecase.dart';
part 'reward/get_rewards_list_usecase.dart';
