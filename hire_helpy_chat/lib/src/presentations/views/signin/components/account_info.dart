import 'package:cached_network_image/cached_network_image.dart';
import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../core/utils/db_utils.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  Map? candidateData;
  String basePhotoUrl = '';

  @override
  void initState() {
    _getPhotoUrl();
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get('forget_user');
    });
  }

  void _getPhotoUrl() async {
    String? data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getAccountInfo(context);
  }

  //Account Info
  _getAccountInfo(context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 80,
      decoration: BoxDecoration(
          color: AppColors.cardColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CachedNetworkImage(
            imageUrl: '$basePhotoUrl/${candidateData!['avatar_s3_filepath']}',
            imageBuilder: (context, imageProvider) => Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.0),
                  color: AppColors.white,
                  image:
                      DecorationImage(fit: BoxFit.cover, image: imageProvider)),
            ),
            placeholder: (context, url) => const SizedBox(
              width: 64,
              height: 64,
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${candidateData!['first_name']} ${candidateData!['last_name']}',
                  style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  'Log in name: ${candidateData!['login_name']} ',
                  style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.primaryGrey,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 21,
                height: 21,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.brandBlue),
                child: Image.asset(
                  'assets/icons/check.png',
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Verified',
                style: TextStyle(fontSize: 12.0, color: AppColors.brandBlue),
              )
            ],
          )
        ],
      ),
    );
  }
}
