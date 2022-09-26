import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/message_model.dart';
import 'package:shamo/pages/widgets/chat_tile.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/providers/page_provider.dart';
import 'package:shamo/services/message_services.dart';
import 'package:shamo/theme.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget Header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text(
          'Message Support',
          style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
        elevation: 0,
        // menghilangkan panah back
        automaticallyImplyLeading: false,
      );
    }

    Widget emptyChat() {
      return Expanded(
          child: Container(
        width: double.infinity,
        color: backgroundColor3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/headset_icon.png',
              width: 80,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Opss No message yet ?",
              style:
                  primaryTextStyle.copyWith(fontWeight: medium, fontSize: 16),
            ),
            SizedBox(
              height: 12,
            ),
            Text("You have never done a transaction",
                style: secondaryTextStyle),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 44,
              child: TextButton(
                onPressed: () {
                  pageProvider.currentIndex = 0;
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Explore Store',
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: medium),
                ),
              ),
            )
          ],
        ),
      ));
    }

    Widget Content() {
      return StreamBuilder<List<MessageModel>>(
          stream: MessageService()
              .getMessagesByUserId(userId: authProvider.user.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length == 0) {
                return emptyChat();
              }
              return Expanded(
                child: Container(
                  width: double.infinity,
                  color: backgroundColor3,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    children: [
                      ChatTile(
                        snapshot.data![snapshot.data!.length - 1],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return emptyChat();
            }
          });
    }

    return Column(
      children: [Header(), Content()],
    );
  }
}
