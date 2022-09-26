import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/message_model.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/pages/widgets/chat_buble.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/services/message_services.dart';
import 'package:shamo/theme.dart';

class DetailChat extends StatefulWidget {
  ProductModel product;
  DetailChat(this.product);

  @override
  State<DetailChat> createState() => _DetailChatState();
}

class _DetailChatState extends State<DetailChat> {
  TextEditingController messageController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleAddMessage() async {
      await MessageService().addMessage(
        user: authProvider.user,
        isFromUser: true,
        product: widget.product,
        message: messageController.text,
      );
      setState(() {
        widget.product = UninitializedProductModel();
        messageController.text = '';
      });
    }

    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: false,
        title: Row(
          children: [
            Image.asset(
              'assets/chat_icon_online.png',
              width: 50,
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shoes Store",
                  style: primaryTextStyle.copyWith(
                      fontWeight: medium, fontSize: 14),
                ),
                Text(
                  "Online",
                  style: secondaryTextStyle.copyWith(
                      fontWeight: light, fontSize: 14),
                )
              ],
            )
          ],
        ),
      );
    }

    Widget productPreview() {
      return Container(
        width: 225,
        height: 74,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: backgroundColor5,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: primaryColor,
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.product.galleries![0].url!,
                width: 54,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name!,
                    style: primaryTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "\$${widget.product.price}",
                    style: priceTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.product = UninitializedProductModel();
                });
              },
              child: Image.asset(
                'assets/close_icon.png',
                width: 22,
              ),
            )
          ],
        ),
      );
    }

    Widget chatInput() {
      return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          //  mengatur ukuran seminimal mungkin
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.product is UninitializedProductModel
                ? SizedBox()
                : productPreview(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        color: backgroundColor4,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: messageController,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Typed Message..',
                            hintStyle: SubtitleTextStyle),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    handleAddMessage();
                  },
                  child: Image.asset(
                    'assets/send_icon.png',
                    width: 45,
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    Widget content() {
      return StreamBuilder<List<MessageModel>>(
          stream: MessageService()
              .getMessagesByUserId(userId: authProvider.user.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                children: snapshot.data!
                    .map((MessageModel message) => ChatBubble(
                          isSender: message.isFromUser!,
                          text: message.message!,
                          product: message.product,
                        ))
                    .toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: header(),
      ),
      bottomNavigationBar: chatInput(),
      body: content(),
    );
  }
}
