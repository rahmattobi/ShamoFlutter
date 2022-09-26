import 'package:flutter/material.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/models/message_model.dart';
import 'package:shamo/pages/detail_chatpage.dart';
import 'package:shamo/theme.dart';

class ChatTile extends StatelessWidget {
  final MessageModel message;
  ChatTile(this.message);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailChat(
              UninitializedProductModel(),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 33),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/logoshop.png',
                  width: 54,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shoes Store',
                        style: primaryTextStyle.copyWith(fontSize: 15),
                      ),
                      Text(
                        message.message!,
                        style: secondaryTextStyle.copyWith(
                            fontSize: 14, fontWeight: light),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Now',
                  style: secondaryTextStyle.copyWith(fontSize: 10),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Divider(
              thickness: 1,
              color: Color(0xff282939),
            )
          ],
        ),
      ),
    );
  }
}
