import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../core/params/params.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../core/utils/loading.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart' as kConnectionBloc;
import '../../../values/values.dart';
import 'empty_chat_request_item.dart';
import 'my_request_item.dart';

class MyRequestList extends StatefulWidget {
  const MyRequestList({super.key});

  @override
  State<MyRequestList> createState() => _MyRequestListState();
}

class _MyRequestListState extends State<MyRequestList> {
  Map? employerData;
  List<ChatRequest> chatRequestList = [];

  @override
  void initState() {
    _getEmployerData();
    super.initState();
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
    });
    _requestMyRequestConnection();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<kConnectionBloc.ConnectionBloc,
        kConnectionBloc.ConnectionState>(builder: (_, state) {
      return chatRequestList.isNotEmpty ? _getMyRequestList  : const EmptyChatRequestItem(title: StringConst.noMyRequestChatTitle, desc: StringConst.noMyRequestChatDesc,);
    }, listener: (_, state) {
      if (state is kConnectionBloc.ConnectionMyRequestSuccess) {
        if (state.connectionData.data != null) {
          List<ChatRequest> data = List<ChatRequest>.from(
              (state.connectionData.data!['data']['data'] as List<dynamic>).map(
                  (e) => ChatRequestModel.fromJson(e as Map<String, dynamic>)));
          setState(() {
            chatRequestList = data;
          });
        }
      }
      if (state is kConnectionBloc.ConnectionMyRequestFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is kConnectionBloc.ConnectionDeleteMyRequestLoading) {
        Loading.showLoading(message: StringConst.loadingText);
      }

      if (state is kConnectionBloc.ConnectionDeleteMyRequestSuccess) {
        Loading.cancelLoading();
        if (state.connectionData.data != null) {
          showInfoModal(
              title: 'You have successfully canceled a chat request.',
              message: 'You can check it on the chat page.',
              type: 'success'
              );
          _requestMyRequestConnection();
        }
      }

      if (state is kConnectionBloc.ConnectionDeleteMyRequestFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  ListView get _getMyRequestList => ListView.builder(
      shrinkWrap: true,
      itemCount: chatRequestList.length,
      itemBuilder: (context, index) {
        return MyRequestItem(chatRequest: chatRequestList[index],);
      });

  void _requestMyRequestConnection() {
    final connectionBloc =
        BlocProvider.of<kConnectionBloc.ConnectionBloc>(context);
    ConnectionGetMyRequestParams params = ConnectionGetMyRequestParams(
      token: employerData!['token'],
      userId: employerData!['user_id'],
    );
    connectionBloc
        .add(kConnectionBloc.ConnectionGetMyRequested(params: params));
  }
}
