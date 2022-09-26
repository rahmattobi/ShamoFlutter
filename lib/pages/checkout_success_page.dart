import 'package:flutter/material.dart';
import 'package:shamo/theme.dart';

class CheckoutSuccess extends StatelessWidget {
  const CheckoutSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor4,
        title: Text('Checkout Success'),
        elevation: 0,
      );
    }

    Widget content() {
      return Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/cart_icon2.png',
                width: 80,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'You made a transaction',
                style: primaryTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Stay at home while we \n prepare your dream shoes',
                style: SubtitleTextStyle,
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30,
                ),
                width: 196,
                height: 44,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    'Order Other Shoes',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 12,
                ),
                width: 196,
                height: 44,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xff393748),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    'View My Order',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: header(),
      ),
      body: content(),
    );
  }
}
