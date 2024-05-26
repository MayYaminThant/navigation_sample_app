import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../../../core/params/params.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../core/utils/loading.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart' as kConnectionBloc;
import '../../../values/values.dart';
import 'conversation_list.dart';
import 'empty_chat_request_item.dart';
import 'incoming_request_item.dart';

class IncomingRequestList extends StatefulWidget {
  const IncomingRequestList({super.key});

  @override
  State<IncomingRequestList> createState() => _IncomingRequestListState();
}

class _IncomingRequestListState extends State<IncomingRequestList> {
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
    _requestIncomingRequestConnection();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<kConnectionBloc.ConnectionBloc,
        kConnectionBloc.ConnectionState>(builder: (_, state) {
      return chatRequestList.isNotEmpty
          ? _getIncomingRequestList
          : const EmptyChatRequestItem(
              title: StringConst.noIncomingChatTitle,
              desc: StringConst.noIncomingChatDesc,
            );
    }, listener: (_, state) async {
      if (state is kConnectionBloc.ConnectionIncomingRequestSuccess) {
        if (state.connectionData.data != null) {
          List<ChatRequest> data = List<ChatRequest>.from(
              (state.connectionData.data!['data']['data'] as List<dynamic>).map(
                  (e) => ChatRequestModel.fromJson(e as Map<String, dynamic>)));
          setState(() {
            chatRequestList = data;
          });
        }
      }
      if (state is kConnectionBloc.ConnectionIncomingRequestFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is kConnectionBloc.ConnectionAcceptRequestLoading) {
        Loading.showLoading(message: StringConst.loadingText);
      }

      if (state is kConnectionBloc.ConnectionAcceptRequestSuccess) {
        Loading.cancelLoading();
        if (state.connectionData.data != null) {
          ConnectionData connectionData =
              ConnectionDataModel.fromJson(state.connectionData.data!['data']);
          await _sendMessage(connectionData);
          _requestIncomingRequestConnection();
          showInfoModal(
              title: 'You have successfully accepted the chat request.',
              message: 'You can chat now in chat page.',
              type: 'success');
        }
      }

      if (state is kConnectionBloc.ConnectionAcceptRequestFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is kConnectionBloc.ConnectionRejectRequestLoading) {
        Loading.showLoading(message: StringConst.loadingText);
      }

      if (state is kConnectionBloc.ConnectionRejectRequestSuccess) {
        Loading.cancelLoading();
        if (state.connectionData.data != null) {
          showInfoModal(
              title: 'You have successfully reject a chat request.',
              message:
                  'The profile will be removing from your any further search.',
              type: 'success');
          _requestIncomingRequestConnection();
        }
      }

      if (state is kConnectionBloc.ConnectionRejectRequestFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  ListView get _getIncomingRequestList => ListView.builder(
      shrinkWrap: true,
      itemCount: chatRequestList.length,
      itemBuilder: (context, index) {
        return IncomingRequestItem(
          chatRequest: chatRequestList[index],
        );
      });

  void _requestIncomingRequestConnection() {
    final connectionBloc =
        BlocProvider.of<kConnectionBloc.ConnectionBloc>(context);
    ConnectionIncomingRequestParams params = ConnectionIncomingRequestParams(
      token: employerData!['token'],
      userId: employerData!['user_id'],
    );
    connectionBloc
        .add(kConnectionBloc.ConnectionGetIncomingRequested(params: params));
  }

  void _goToChatDetail(ConnectionData data) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ConversationPage(
          conversationID: data.candidateUserId.toString(),
          conversationType: ZIMConversationType.peer,
        );
      },
    ));
  }

  Future<void> _sendMessage(ConnectionData connectionData) async {
    // 3. Send messages.
    ZIMTextMessage textMessage = ZIMTextMessage(
        message:
            '${employerData!['first_name']} ${employerData!['last_name']} accepted your request.');
    ZIMMessageSendConfig sendConfig = ZIMMessageSendConfig();
    // Set the message priority.
    sendConfig.priority = ZIMMessagePriority.high;

    ZIMPushConfig pushConfig = ZIMPushConfig();
    pushConfig.title = "Offline notification title";
    pushConfig.content = "Offline notification content";
    sendConfig.pushConfig = pushConfig;
    ZIMMessageSendNotification notification =
        ZIMMessageSendNotification(onMessageAttached: (message) {
      // The callback on the message not sent yet. Before the message is sent, you can get a temporary ZIMMessage message for you to implement your business logic as needed.
    });

    // 4. Set conversation type. Set it based on your conversation type.
    // Send one-on-one messages.
    ZIMConversationType type = ZIMConversationType.peer;

    await ZIM.getInstance()!.sendMessage(textMessage,
        connectionData.candidateUserId.toString(), type, sendConfig);
    _goToChatDetail(connectionData);
  }
}
