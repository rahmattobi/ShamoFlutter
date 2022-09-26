import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/pages/widgets/favorit_tile.dart';
import 'package:shamo/providers/page_provider.dart';
import 'package:shamo/providers/wishlist_provider.dart';
import 'package:shamo/theme.dart';

class FavoritPage extends StatelessWidget {
  const FavoritPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    Widget Header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text(
          'Favorit Shoes',
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
              'assets/love_icon.png',
              width: 80,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "You don't have dream shoes ?",
              style:
                  primaryTextStyle.copyWith(fontWeight: medium, fontSize: 16),
            ),
            SizedBox(
              height: 12,
            ),
            Text("Let's find your favorite shoes", style: secondaryTextStyle),
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
      return Expanded(
        child: Container(
          width: double.infinity,
          color: backgroundColor3,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            children: wishlistProvider.wishlist
                .map((product) => FavoriteTile(product))
                .toList(),
          ),
        ),
      );
    }

    return Column(
      children: [
        Header(),
        wishlistProvider.wishlist.length == 0 ? emptyChat() : Content(),
      ],
    );
  }
}
