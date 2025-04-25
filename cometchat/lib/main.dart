import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'MessagesScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CometChat UI Kit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    initializeCometChat();
  }

  void initializeCometChat() async {
    UIKitSettings uiKitSettings = (UIKitSettingsBuilder()
      ..subscriptionType = CometChatSubscriptionType.allUsers
      ..region = "IN" // Your region
      ..appId = "2738620b2efff3f4" // Replace with your App ID
      ..authKey = "3fc0d587e93403472710b6c9a8e305b47cab0f11" // Replace with your Auth Key
      ..autoEstablishSocketConnection = true).build();

    try {
      await CometChatUIKit.init(uiKitSettings: uiKitSettings);
      debugPrint("✅ CometChat Initialized");

      await CometChatUIKit.login(
        "cometchat-uid-1",
        onSuccess: (User user) {
          debugPrint("✅ Logged in as ${user.name}");
          setState(() {
            isLoggedIn = true;
          });
        },
        onError: (e) => debugPrint("❌ Login failed: $e"),
      );
    } catch (e) {
      debugPrint("❌ Initialization error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoggedIn
          ? CometChatConversations(
        onItemTap: (conversation) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessagesScreen(
                user: conversation.conversationWith is User
                    ? conversation.conversationWith as User
                    : null,
                group: conversation.conversationWith is Group
                    ? conversation.conversationWith as Group
                    : null,
              ),
            ),
          );
        },
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
