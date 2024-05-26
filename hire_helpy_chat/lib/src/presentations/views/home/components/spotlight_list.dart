import 'package:carousel_slider/carousel_slider.dart';
import 'package:dh_employer/src/core/params/params.dart';
import 'package:dh_employer/src/core/utils/spotlight_latest_cache.dart';
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
  List<Candidate> _candidateList = [];
  String category = 'Popular';
  List<String> spotLightList = ['Popular', 'Latest', 'Transfer Help'];
  int _currentIndex = 0;

  @override
  void initState() {
    _requestSpotlightList();
    super.initState();
  }

  @override
  Widget build(context) {
    return BlocConsumer<EmployerBloc, EmployerState>(
      builder: (_, state) {
        return _getSpotlightList;
      },
      listener: (_, state) async {
        if (state is EmployerCreateSpotlightsSuccess) {
          if (state.data.data != null) {
            List<Candidate> data = List<Candidate>.from(
                (state.data.data!['data'] as List<dynamic>).map(
                    (e) => CandidateModel.fromJson(e as Map<String, dynamic>)));
            final spotlightLatestCache = SpotlightLatestCache();
            refreshCallback() {
              setState(() {
                _candidateList =
                    _reorganiseProfiles(category: category, profiles: data);
                print(_candidateList[0]);
              });
            }

            refreshCallback();
            if (category == 'Latest') {
              spotlightLatestCache.registerReloadCallback(refreshCallback);
            }
          }
        }

        if (state is EmployerCreateSpotlightsFail) {
          if (state.message != '') {
            showErrorSnackBar(state.message);
          }
        }
      },
    );
  }

  List<Candidate> _reorganiseProfiles(
      {required String category, required List<Candidate> profiles}) {
    if (category != 'Latest') return profiles;

    final spotlightLatestCache = SpotlightLatestCache();
    return spotlightLatestCache.generateLatestDisplayProfiles(profiles);
  }

  Widget get _getSpotlightList {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getPopularListView,
        SizedBox(
            height: 220,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider(
              items: _candidateList.map((candidate) {
                return Builder(
                  builder: (BuildContext context) {
                    return HomeListItem(
                      key: UniqueKey(),
                      candidate: candidate,
                      candidateList: _candidateList,
                      index: _currentIndex,
                    );
                  },
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
        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
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
                    category = spotLightList[index];
                    _candidateList.clear();
                    _requestSpotlightList();
                  }),
                  child: Text(
                    spotLightList[index].tr,
                    style: TextStyle(
                        color: category == spotLightList[index]
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
  _requestSpotlightList() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerSpotlightsRequestParams params =
        EmployerSpotlightsRequestParams(category: _getCategory());
    employerBloc.add(EmployerSpotlightsRequested(params: params));
  }

  _getCategory() {
    return category
        .replaceAll(' ', '')
        .replaceFirst(category[0], category[0].toLowerCase());
  }

  @override
  void dispose() {
    super.dispose();
    final spotlightLatestCache = SpotlightLatestCache();
    return spotlightLatestCache.cancelReloadCallback();
  }
}
