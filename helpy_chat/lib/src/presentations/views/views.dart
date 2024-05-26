library views;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:dh_mobile/src/core/utils/environment_manager.dart';

// import 'package:camera/camera.dart';
import 'package:dh_mobile/src/core/utils/image_utils.dart';
import 'package:dh_mobile/src/core/utils/otp_verification.dart';
import 'package:dh_mobile/src/core/utils/shortlink.dart';
import 'package:dh_mobile/src/core/utils/work_permit_photo.dart';
import 'package:dh_mobile/src/data/models/faq_data_model.dart';
import 'package:dh_mobile/src/domain/entities/entities.dart';
import 'package:dh_mobile/src/presentations/views/articles_and_news/components/article_profile_display.dart';
import 'package:dh_mobile/src/presentations/views/articles_and_news/components/no_article.dart';
import 'package:dh_mobile/src/presentations/views/articles_and_news/components/no_news.dart';
import 'package:dh_mobile/src/presentations/views/home/components/marquee_text_home.dart';
import 'package:dh_mobile/src/presentations/views/home/components/simple_search_modal.dart';
import 'package:dh_mobile/src/presentations/views/side_menu/components/menu_item.dart';
import 'package:dh_mobile/src/presentations/widgets/super_print.dart';
import 'package:dh_mobile/src/presentations/widgets/upload_preview.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../core/utils/ad_helper.dart';
import '../../core/utils/authenication.dart';
import '../../core/utils/configs_key_helper.dart';
import '../../core/utils/language_utils.dart';
import '../../core/utils/login_resume.dart';
import '../../data/models/comment_article_model.dart';
import '../../domain/entities/entities.dart' as noti;
import 'package:dh_mobile/src/presentations/views/employeer/components/employer_profile_item.dart';
import 'package:dh_mobile/src/presentations/views/home/components/event_list_home.dart';
import 'package:dh_mobile/src/presentations/views/my_account/components/error_pop_up.dart';
import 'package:dh_mobile/src/presentations/views/register/components/employment_history_modal.dart';
import 'package:dh_mobile/src/presentations/views/register/components/employment_item.dart';
import 'package:dh_mobile/src/presentations/views/saved_search/components/empty_saved_search_item.dart';
import 'package:dh_mobile/src/presentations/views/home/components/normal_range_text.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as k_flutter_contacts;
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:video_thumbnail/video_thumbnail.dart' as video_thumbnail;
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:video_player/video_player.dart';
// Add an alias 'flutter'

import '../../config/routes/routes.dart';
import '../../core/params/params.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/db_utils.dart';
import '../../core/utils/firebase_utils.dart';
import '../../core/utils/loading.dart';
import '../../core/utils/noti.dart';
import '../../core/utils/snackbar_utils.dart';
import '../../core/utils/string_utils.dart';
import '../../core/utils/version_helper.dart';
import '../../data/models/models.dart';
import '../blocs/blocs.dart';
import '../values/values.dart';
import '../widgets/background_scaffold.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/custom_year_picker.dart';
import '../widgets/image_slider.dart';
import '../widgets/slider_captcha.dart';
import '../widgets/widgets.dart';
import 'articles_and_news/components/comment_form.dart';
import 'articles_and_news/components/comment_item.dart';
import 'articles_and_news/components/delete_article_modal.dart';
import 'contact_us/components/message_sent_pop_up.dart';
import 'employeer/components/employer_flag.dart';
import 'home/components/ads_slider.dart';
import 'home/components/articles_list_home.dart';
import 'home/components/company_social_links.dart';
import 'home/components/currency_field.dart';
import 'home/components/employee_skills.dart';
import 'home/components/language_skills.dart';
import 'home/components/new_list.dart';
import 'home/components/register_enjoy_pop_up.dart';
import 'home/components/reveal_search_pop_up.dart';
import 'home/components/spotlight_list.dart';
import 'my_account/components/card_account_info.dart';
import 'notification/components/empty_message.dart';
import 'phluid_coins/components/coin_empty_list.dart';
import 'phluid_coins/components/coin_item.dart';
import 'profile/components/empty_profile_container.dart';

// import 'profile/components/upload_photo_modal.dart';
import 'refer_friend/components/campaign_item.dart';
import 'refer_friend/components/refer_friend_contact_item.dart';
import 'refer_friend/components/refer_friend_item.dart';
import 'register/components/bottom_navigation_item.dart';
import 'register/components/profile_error_popup.dart';
import 'register/components/profile_stepper.dart';
import 'register/components/value_error_popup.dart';
import 'reviews/components/rating_modal.dart';
import 'reviews/components/review_item.dart';
import 'rewards/components/carousel_cubit.dart';
import 'rewards/components/expandable_page_view.dart';
import 'rewards/components/no_reward.dart';
import 'rewards/components/reward_card.dart';
import 'saved_search/components/auto_send_notification.dart';
import 'saved_search/components/saved_search_card.dart';
import 'search_result/components/empty_result_item.dart';
import 'setting/components/custom_expansion_tile.dart';
import 'side_menu/components/menu_divider.dart';
import 'side_menu/components/sub_menu.dart';
import 'signin/components/account_info.dart';
import 'signin/components/continue_with_social.dart';
import 'signin/components/otp_field.dart';
import 'star_list/components/page_view_indicator.dart';
import '../blocs/blocs.dart' as k_connection_bloc;
import 'contact_us/components/expansion_tile_widget.dart';
import 'chat/components/chat_item.dart';
import 'chat/components/chat_user_info.dart';
import 'chat/components/empty_chat_request_item.dart';
import 'chat/components/incoming_request_list.dart';
import 'chat/components/my_request_list.dart';
import 'chat/components/phluid_message_terms.dart';
import 'chat/components/unlink_validation_modal.dart';
import '../widgets/upload_media.dart';
import 'package:image/image.dart' as imglib;

part 'articles_and_news/sections/news_list_section.dart';

part 'articles_and_news/sections/article_event_detail.dart';

part 'chat/sections/chat_details_section.dart';

part 'chat/sections/chat_list_section.dart';

part 'contact_us/sections/contact_us_section.dart';

part 'employeer/sections/emoployeer_profile_section.dart';

part 'home/sections/advanced_search_section.dart';

part 'home/sections/home_section.dart';

part 'home/components/save_big_data_modal.dart';

part 'my_account/sections/my_account_section.dart';

part 'phluid_coins/sections/phluid_coin_section.dart';

part 'profile/sections/dh_profile_section.dart';

part 'refer_friend/sections/refer_friend_section.dart';

part 'register/components/declaration_modal.dart';

part 'register/components/upload_work_permit_modal.dart';

part 'register/components/work_permit_modal.dart';

part 'register/sections/about_me_section.dart';

// part 'register/sections/camera_section.dart';

part 'register/sections/family_information_section.dart';

part 'register/sections/profile_creation_success.dart';

part 'register/sections/register_section.dart';

part 'register/sections/skill_and_qualification_section.dart';

part 'register/sections/verified_success_section.dart';

part 'register/sections/verify_section.dart';

part 'register/sections/work_experience_section.dart';

part 'register/sections/working_preferences_section.dart';

part 'register/sections/work_permit_camera_section.dart';

part 'register/sections/work_permit_select_image_section.dart';

part 'reviews/sections/reviews_section.dart';

part 'saved_search/sections/saved_search_section.dart';

part 'search_result/sections/search_result_section.dart';

part 'setting/sections/setting_section.dart';

part 'side_menu/sections/side_menu.dart';

part 'signin/sections/account_check_section.dart';

part 'signin/sections/forgot_otp_section.dart';

part 'signin/sections/forgot_password_section.dart';

part 'signin/sections/recovered_success_section.dart';

part 'signin/sections/reset_password_section.dart';

part 'signin/sections/signin_section.dart';

part 'splash/sections/splash_section.dart';

part 'star_list/sections/star_list_section.dart';

part 'terms/sections/terms_sections.dart';

part 'my_account/sections/verify_account_info_section.dart';

part 'refer_friend/sections/redeem_friends_list.dart';

part 'articles_and_news/sections/article_create_section.dart';

part 'notification/sections/notification_section.dart';

part 'star_list/sections/nonlogin_info_section.dart';

part 'register/sections/unauthenicated_section.dart';

part 'installed_app/sections/installed_app_section.dart';

part 'rewards/sections/reward_section.dart';

part 'search_result/sections/profile_desk_section.dart';

part 'language_and_country/sections/language_country_section.dart';

part 'signin/sections/signin_email_section.dart';

part 'signin/sections/signin_phone_section.dart';

part 'contact_us/sections/customer_suport_section.dart';

part 'my_account/sections/country_work_section.dart';

part 'my_account/sections/language_change_section.dart';

part 'rewards/sections/reward_detail_section.dart';

part 'articles_and_news/sections/news_detail_section.dart';

part 'no_internet/sections/no_internet_section.dart';

part 'chat/sections/chat_request_section.dart';

part 'articles_and_news/sections/article_update_section.dart';

part 'reviews/components/empty_review.dart';
