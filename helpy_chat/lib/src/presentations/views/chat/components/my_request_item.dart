import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../core/params/params.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart' as k_connection_bloc;
import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class MyRequestItem extends StatefulWidget {
  const MyRequestItem({super.key, required this.chatRequest});
  final ChatRequest chatRequest;

  @override
  State<MyRequestItem> createState() => _MyRequestItemState();
}

class _MyRequestItemState extends State<MyRequestItem> {
  String basePhotoUrl = '';
  Map? candidateData;

  @override
  void initState() {
    _initLoad();
    super.initState();
  }

  Future<void> _initLoad() async {
    await _getCandidateData();
    await _getPhotoUrl();
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
    });
  }

  Future<void> _getPhotoUrl() async {
    String data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getMyRequestContianer;
  }

  Container get _getMyRequestContianer => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Row(
          children: [_getUserProfile, _getUserInfo],
        ),
      );

  //ImageView
  Widget get _getUserProfile => Container(
        width: 85,
        height: 85,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40.0)),
            color: AppColors.white,
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                '$basePhotoUrl/${widget.chatRequest.receiver!.avatar ?? ''}',
              ),
              fit: BoxFit.cover,
            )),
      );

  //User Info
  Widget get _getUserInfo => Container(
        padding: const EdgeInsets.only(left: 10.0),
        width: MediaQuery.of(context).size.width - 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringUtils.getShortName(
                  widget.chatRequest.receiver!.firstName ?? '',
                  widget.chatRequest.receiver!.lastName ?? ''),
              style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
            const Text(
              StringConst.myRequestSubTitle,
              style: TextStyle(
                  color: AppColors.primaryGrey,
                  fontSize: 10,
                  fontWeight: FontWeight.w100),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomPrimaryButton(
              customColor: AppColors.backgroundGrey.withOpacity(0.1),
              text: StringConst.cancelRequestText,
              widthButton: MediaQuery.of(context).size.width - 130,
              onPressed: () => _removeMyRequest(),
            ),
          ],
        ),
      );

  void _removeMyRequest() {
    final connnectionBloc =
        BlocProvider.of<k_connection_bloc.ConnectionBloc>(context);
    ConnectionCancelRequestParams params = ConnectionCancelRequestParams(
        token: candidateData!['token'],
        chatRequestId: widget.chatRequest.chatRequestId);
    connnectionBloc
        .add(k_connection_bloc.ConnectionDeleteMyRequested(params: params));
  }
}
