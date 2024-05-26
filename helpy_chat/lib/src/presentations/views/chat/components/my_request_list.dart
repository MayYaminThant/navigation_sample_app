import 'package:dh_mobile/src/core/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../core/params/params.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart' as k_connection_bloc;
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

  Future<void> _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.candidateTableName);
    });
    _requestMyRequestConnection();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<k_connection_bloc.ConnectionBloc,
        k_connection_bloc.ConnectionState>(builder: (_, state) {
      return chatRequestList.isNotEmpty ? _getMyRequestList  : const EmptyChatRequestItem(title: StringConst.noMyRequestChatTitle, desc: StringConst.noMyRequestChatDesc,);
    }, listener: (_, state) {
      if (state is k_connection_bloc.ConnectionMyRequestSuccess) {

        if (state.connectionData.data != null) {
          List<ChatRequest> data = List<ChatRequest>.from(
              (state.connectionData.data!['data']['data'] as List<dynamic>).map(
                  (e) => ChatRequestModel.fromJson(e as Map<String, dynamic>)));
          setState(() {
            chatRequestList = data;
          });
        }
      }

      if (state is k_connection_bloc.ConnectionMyRequestFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is k_connection_bloc.ConnectionDeleteMyRequestLoading) {
        Loading.showLoading(message: StringConst.loadingText);
      }

      if (state is k_connection_bloc.ConnectionDeleteMyRequestSuccess) {
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

      if (state is k_connection_bloc.ConnectionDeleteMyRequestFail) {
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
        return MyRequestItem(
          chatRequest: chatRequestList[index],
        );
      });

  void _requestMyRequestConnection() {
    final connectionBloc =
        BlocProvider.of<k_connection_bloc.ConnectionBloc>(context);
    ConnectionGetMyRequestParams params = ConnectionGetMyRequestParams(
      token: employerData!['token'],
      userId: employerData!['user_id'],
    );
    connectionBloc
        .add(k_connection_bloc.ConnectionGetMyRequested(params: params));
  }
}
