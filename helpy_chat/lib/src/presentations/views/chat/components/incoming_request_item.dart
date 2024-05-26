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

class IncomingRequestItem extends StatefulWidget {
  const IncomingRequestItem({super.key, required this.chatRequest});

  final ChatRequest chatRequest;

  @override
  State<IncomingRequestItem> createState() => _IncomingRequestItemState();
}

class _IncomingRequestItemState extends State<IncomingRequestItem> {
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
    return _getIncomingRequestContianer;
  }

  Container get _getIncomingRequestContianer => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        width: MediaQuery.of(context).size.width,
        height: 125,
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
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                '$basePhotoUrl/${widget.chatRequest.sender!.avatar ?? ''}',
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
                  widget.chatRequest.sender!.firstName ?? '',
                  widget.chatRequest.sender!.lastName ?? ''),
              style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
            const Text(
              StringConst.incomingRequestSubTitle,
              style: TextStyle(
                  color: AppColors.primaryGrey,
                  fontSize: 10,
                  fontWeight: FontWeight.w100),
            ),
            const SizedBox(
              height: 10,
            ),
            Table(
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: CustomPrimaryButton(
                        customColor: AppColors.secondaryGreen.withOpacity(0.3),
                        text: StringConst.acceptRequestText,
                        onPressed: () => _acceptRequest(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: CustomPrimaryButton(
                        customColor: AppColors.backgroundGrey.withOpacity(0.1),
                        text: StringConst.declineRequestText,
                        onPressed: () => _declineRequest(),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      );

  void _acceptRequest() {
    final connectionBloc =
        BlocProvider.of<k_connection_bloc.ConnectionBloc>(context);
    ConnectionAcceptRequestParams params = ConnectionAcceptRequestParams(
        token: candidateData!['token'],
        chatRequestId: widget.chatRequest.chatRequestId);
    connectionBloc
        .add(k_connection_bloc.ConnectionCreateAcceptRequested(params: params));
  }

  void _declineRequest() {
    final connectionBloc =
        BlocProvider.of<k_connection_bloc.ConnectionBloc>(context);
    ConnectionRejectRequestParams params = ConnectionRejectRequestParams(
        token: candidateData!['token'],
        chatRequestId: widget.chatRequest.chatRequestId);
    connectionBloc
        .add(k_connection_bloc.ConnectionCreateRejectRequested(params: params));
  }
}
