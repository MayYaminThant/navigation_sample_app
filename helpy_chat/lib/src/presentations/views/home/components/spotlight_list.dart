import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dh_mobile/src/core/params/params.dart';
import 'package:dh_mobile/src/core/utils/db_utils.dart';
import 'package:dh_mobile/src/core/utils/spotlight_latest_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../core/utils/snackbar_utils.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart';
import '../../../values/values.dart';
import 'spotlight_list_item.dart';

class SportLightList extends StatefulWidget {
  const SportLightList({super.key});

  @override
  State<SportLightList> createState() => _SportLightListState();
}

class _SportLightListState extends State<SportLightList> {
  List<Employer> _employerList = [];
  String category = 'popular';
  List<Map<String, String>> spotLightList = [
    {'label': 'Popular', 'key': 'popular'},
    {'label': 'Latest', 'key': 'latest'},
    {'label': 'Challenge Accepted', 'key': 'challengeAccepted'},
  ];
  int _currentIndex = 0;
  String basePhotoUrl = '';
  Timer timer = Timer(Duration.zero, () {});

  Future<void> _getPhotoUrl() async {
    String? data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    if (data != null) {
      setState(() {
        basePhotoUrl = data;
      });
    }
  }

  @override
  void initState() {
    _getPhotoUrl();
    _requestSpotlightList();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(context) {
    return BlocConsumer<CandidateBloc, CandidateState>(
      builder: (_, state) {
        return _getSpotlightList;
      },
      listener: (_, state) {
        if (state is CandidateCreateSpotlightsSuccess) {
          if (state.data.data != null) {
            List<Employer> data = List<Employer>.from((state.data.data!['data']
                    as List<dynamic>)
                .map((e) => EmployerModel.fromJson(e as Map<String, dynamic>)));
            setState(() {
              _employerList =
                  _reorganiseProfiles(category: category, profiles: data);
            });
          }
        }
        if (state is CandidateCreateSpotlightsFail) {
          if (state.message != '') {
            showErrorSnackBar(state.message);
          }
        }
      },
    );
  }

  List<Employer> _reorganiseProfiles(
      {required String category, required List<Employer> profiles}) {
    if (category != 'Latest') return profiles;

    final spotlightLatestCache = SpotlightLatestCache();
    return spotlightLatestCache.generateLatestDisplayProfiles(profiles);
  }

  Widget get _getSpotlightList {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getPopularListView,
        _employerList.isEmpty
            ? SizedBox(
                height: 220,
                width: MediaQuery.of(context).size.width,
              )
            : SizedBox(
                height: 220,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  items: _employerList.map((employer) {
                    return SpotlightListItem(
                      employer: employer,
                      employerList: _employerList,
                      index: _currentIndex,
                      basePhotoUrl: basePhotoUrl,
                    );
                  }).toList(),
                  options: CarouselOptions(
                      autoPlay: true,
                      padEnds: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      autoPlayInterval: const Duration(milliseconds: 3000)),
                ))
      ],
    );
  }

  Widget get _getPopularListView => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: spotLightList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () => setState(() {
                    category = spotLightList[index]['key']!;
                    _employerList.clear();
                    _requestSpotlightList();
                    _currentIndex = 0;
                  }),
                  child: Text(
                    spotLightList[index]['label']!.tr,
                    style: TextStyle(
                        color: category == spotLightList[index]['key']!
                            ? AppColors.white
                            : AppColors.primaryGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              );
            },
          ),
        ),
      );

  //Spotlight Requested
  void _requestSpotlightList() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateSpotlightsRequestParams params =
        CandidateSpotlightsRequestParams(category: category);
    candidateBloc.add(CandidateSpotlightsRequested(params: params));
  }
}
