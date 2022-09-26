import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/pages/widgets/product_card.dart';
import 'package:shamo/pages/widgets/product_tile.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/providers/product_provider.dart';
import 'package:shamo/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget Header() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${user.name} ',
                    style: primaryTextStyle.copyWith(
                        fontSize: 24, fontWeight: semiBold),
                  ),
                  Text(
                    '@${user.email}',
                    style: SubtitleTextStyle.copyWith(fontSize: 16),
                  )
                ],
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    // kalo foto tambahkan tanda seru untuk type string yang tidak dideclarasikan
                    user.profilePhotoUrl!,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget Category() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: defaultMargin,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primaryColor),
                child: Text(
                  'All Shoes',
                  style: primaryTextStyle.copyWith(
                      fontSize: 13, fontWeight: medium),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: subtitleColor,
                    ),
                    color: transparentColor),
                child: Text(
                  'Running',
                  style: SubtitleTextStyle.copyWith(
                      fontSize: 13, fontWeight: medium),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: subtitleColor,
                    ),
                    color: transparentColor),
                child: Text(
                  'Training',
                  style: SubtitleTextStyle.copyWith(
                      fontSize: 13, fontWeight: medium),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: subtitleColor,
                    ),
                    color: transparentColor),
                child: Text(
                  'Basket Ball',
                  style: SubtitleTextStyle.copyWith(
                      fontSize: 13, fontWeight: medium),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: subtitleColor,
                    ),
                    color: transparentColor),
                child: Text(
                  'Hiking',
                  style: SubtitleTextStyle.copyWith(
                      fontSize: 13, fontWeight: medium),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget PopularProductTitle() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultMargin, left: defaultMargin, right: defaultMargin),
        child: Text(
          'Popular Product',
          style: primaryTextStyle.copyWith(fontSize: 22, fontWeight: semiBold),
        ),
      );
    }

    Widget PopularProducts() {
      return Container(
        margin: EdgeInsets.only(top: 14),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: defaultMargin,
              ),
              Row(
                children: productProvider.products
                    .map(
                      (product) => ProductCard(product),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      );
    }

    Widget NewArrivalTitle() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultMargin, left: defaultMargin, right: defaultMargin),
        child: Text(
          'New Arrivals',
          style: primaryTextStyle.copyWith(fontSize: 22, fontWeight: semiBold),
        ),
      );
    }

    Widget newArrval() {
      return Container(
        margin: EdgeInsets.only(top: 14),
        child: Column(
          children: productProvider.products
              .map(
                (product) => ProductTile(product),
              )
              .toList(),
        ),
      );
    }

    return ListView(
      children: [
        Header(),
        Category(),
        PopularProductTitle(),
        PopularProducts(),
        NewArrivalTitle(),
        newArrval()
      ],
    );
  }
}
