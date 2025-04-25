import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

class MessagesScreen extends StatelessWidget {
  final User? user;
  final Group? group;

  const MessagesScreen({Key? key, this.user, this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CometChatMessageHeader(user: user, group: group),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: CometChatMessageList(user: user, group: group)),
            CometChatMessageComposer(user: user, group: group),
          ],
        ),
      ),
    );
  }
}
