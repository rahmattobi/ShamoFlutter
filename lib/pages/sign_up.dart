import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/pages/widgets/loading_button.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/theme.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final globalKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController(text: '');

  TextEditingController usernameController = TextEditingController(text: '');

  TextEditingController emailController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    handleSignUp() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.register(
        name: nameController.text,
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
      )) {
        Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Gagal Register!',
              textAlign: TextAlign.center,
            )));
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget Header() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign Up',
              style:
                  primaryTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
            ),
            SizedBox(
              height: 2,
            ),
            Text('Register and Happy Shopping', style: SubtitleTextStyle)
          ],
        ),
      );
    }

    Widget FullnameInput() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name',
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: backgroundColor2,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/username_icon.png',
                      width: 17,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextFormField(
                      style: primaryTextStyle,
                      controller: nameController,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Your Full Name',
                          hintStyle: SubtitleTextStyle),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget UsernameInput() {
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: backgroundColor2,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/union_icon.png',
                      width: 17,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextFormField(
                      style: primaryTextStyle,
                      controller: usernameController,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Your Username',
                          hintStyle: SubtitleTextStyle),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget EmailInput() {
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Address',
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: backgroundColor2,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/email_icon.png',
                      width: 17,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextFormField(
                      style: primaryTextStyle,
                      controller: emailController,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Your Email Address',
                          hintStyle: SubtitleTextStyle),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget PasswordInput() {
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Password',
                style: primaryTextStyle.copyWith(
                    fontSize: 16, fontWeight: medium)),
            SizedBox(height: 12),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: backgroundColor2,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/password_icon.png',
                      width: 17,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextFormField(
                      style: primaryTextStyle,
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Your Password',
                          hintStyle: SubtitleTextStyle),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget SignUpButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: handleSignUp,
          style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text(
            'Sign Up',
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
        ),
      );
    }

    Widget Footer() {
      return Container(
        margin: EdgeInsets.only(top: 30, bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already have an account? ',
                style: SubtitleTextStyle.copyWith(
                  fontSize: 12,
                )),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(' Sign In',
                  style: PuprleTextStyle.copyWith(
                      fontSize: 12, fontWeight: medium)),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Header(),
              FullnameInput(),
              UsernameInput(),
              EmailInput(),
              PasswordInput(),
              isLoading ? LoadingButton() : SignUpButton(),
              Spacer(),
              Footer()
            ],
          ),
        ),
      ),
    );
  }
}
