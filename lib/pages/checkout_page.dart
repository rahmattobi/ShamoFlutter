import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/pages/widgets/checkout_card.dart';
import 'package:shamo/pages/widgets/loading_button.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/providers/cart_provider.dart';
import 'package:shamo/providers/transaction_provider.dart';
import 'package:shamo/theme.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });
      if (await transactionProvider.checkout(authProvider.user.token!,
          cartProvider.carts, cartProvider.totalPrice())) {
        cartProvider.carts = [];
        Navigator.pushNamedAndRemoveUntil(
            context, '/checkout-success', (route) => false);
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text('Checkout Details'),
        elevation: 0,
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List Item',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                Column(
                  children: cartProvider.carts
                      .map(
                        (cart) => CheckoutCard(cart),
                      )
                      .toList(),
                )
              ],
            ),
          ),

          // NOTE: ADDRESS DETAILS
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: backgroundColor4,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address Details',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/building_icon.png',
                          width: 40,
                        ),
                        Image.asset(
                          'assets/line_icon.png',
                          height: 30,
                        ),
                        Image.asset(
                          'assets/location_icon.png',
                          width: 40,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Store Location',
                          style: secondaryTextStyle.copyWith(
                            fontWeight: light,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Adidas Core',
                          style: primaryTextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                        SizedBox(
                          height: defaultMargin,
                        ),
                        Text(
                          'Your Address',
                          style: secondaryTextStyle.copyWith(
                            fontWeight: light,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Maek',
                          style: primaryTextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          // NOTE: PAYMENT SUMMARY
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: backgroundColor4,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Summary',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product Quantity',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${cartProvider.totalItems()} Items',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product Price',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '\$${cartProvider.totalPrice()}',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Free',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 21,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: priceTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      '\$${cartProvider.totalPrice()}',
                      style: priceTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // CHECKOUT BUTTON
          SizedBox(
            height: defaultMargin,
          ),
          Divider(
            thickness: 0.3,
            color: subtitleColor,
          ),
          isLoading
              ? Container(
                  margin: EdgeInsets.only(bottom: defaultMargin),
                  child: LoadingButton())
              : Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    vertical: defaultMargin,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: () {
                      handleCheckout();
                    },
                    child: Text(
                      'Checkout Now',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: header(),
      ),
      body: content(),
      // bottomNavigationBar: customBottomNav(),
    );
  }
}
