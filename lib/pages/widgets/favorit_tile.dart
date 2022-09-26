import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/providers/wishlist_provider.dart';
import 'package:shamo/theme.dart';

class FavoriteTile extends StatelessWidget {
  final ProductModel productModel;
  FavoriteTile(this.productModel);

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(
        top: 10,
        right: 20,
        left: 12,
        bottom: 14,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor4,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              productModel.galleries![0].url!,
              width: 60,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.name!,
                  style: primaryTextStyle.copyWith(fontWeight: semiBold),
                ),
                // SizedBox(
                //   height: 8,
                // ),
                Text(
                  '\$${productModel.price}',
                  style: priceTextStyle,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              wishlistProvider.setProduct(productModel);
            },
            child: Image.asset(
              'assets/love_icon2.png',
              width: 34,
            ),
          )
        ],
      ),
    );
  }
}
