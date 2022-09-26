import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/cart_model.dart';
import 'package:shamo/providers/cart_provider.dart';
import 'package:shamo/theme.dart';

class CartCard extends StatelessWidget {
  final CartModel cartModel;
  CartCard(this.cartModel);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Container(
      margin: EdgeInsets.only(
        top: defaultMargin,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                      cartModel.product!.galleries![0].url!,
                    ),
                  ),
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
                      cartModel.product!.name!,
                      style: primaryTextStyle.copyWith(fontWeight: semiBold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '\$${cartModel.product!.price!}',
                      style: priceTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      cartProvider.addQuantity(cartModel.id!);
                    },
                    child: Image.asset(
                      'assets/button_add.png',
                      width: 16,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    cartModel.quantity.toString(),
                    style: primaryTextStyle.copyWith(fontWeight: medium),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      cartProvider.reduceQuantity(cartModel.id!);
                    },
                    child: Image.asset(
                      'assets/button_min.png',
                      width: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              cartProvider.removeCart(cartModel.id!);
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/subtract_icon.png',
                  width: 10,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'Remove',
                  style: alerTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: light,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
