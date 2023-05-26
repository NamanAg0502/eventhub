import 'package:appwrite/appwrite.dart';
import 'package:eventhub/main.dart';
import 'package:eventhub/widgets/buttons/navigate_button.dart';
import 'package:eventhub/widgets/buttons/social_button.dart';
import 'package:eventhub/widgets/inputs/text_input.dart';
import 'package:eventhub/widgets/toast/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get the Appwrite client
    final client = AppwriteProvider.of(context)!.client;
    // Get the Account service
    Account account = Account(client);

    void registerUser() {
      account
          .create(
              userId: ID.unique(),
              email: emailController.text,
              password: passwordController.text,
              name: nameController.text)
          .then((value) {
        Navigator.pushNamed(context, '/home');
        showToast(context, 'Account created successfully', isError: false);
      }).catchError((error) {
        print(error);
        showToast(context, error.message, isError: true);
      });
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(
                CupertinoIcons.chevron_left,
                color: Color(0xff120D26),
              ),
            )),
        body: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 28),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff120D26)),
                      ),
                      const SizedBox(height: 20),
                      CustomTextInput(
                          controller: nameController,
                          prefixIcon: CupertinoIcons.person,
                          label: 'Full name'),
                      const SizedBox(height: 20),
                      CustomTextInput(
                          controller: emailController,
                          prefixIcon: CupertinoIcons.mail,
                          label: 'abc@email.com'),
                      const SizedBox(height: 20),
                      CustomTextInput(
                          controller: passwordController,
                          prefixIcon: CupertinoIcons.lock,
                          label: 'Your password',
                          isPassword: true),
                      const SizedBox(height: 20),
                      CustomTextInput(
                          controller: confirmPasswordController,
                          prefixIcon: CupertinoIcons.lock,
                          label: 'Confirm password',
                          isPassword: true),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: NavigateButton(
                            label: 'SIGN UP',
                            icon: CupertinoIcons.arrow_right,
                            onTap: registerUser),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'OR',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff9D9898)),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(children: [
                    SocialLoginButton(
                        text: 'Login with Google',
                        imagePath: 'assets/images/icons/google.png',
                        onTap: () {}),
                    const SizedBox(height: 20),
                    SocialLoginButton(
                        text: 'Login with Facebook',
                        imagePath: 'assets/images/icons/facebook.png',
                        onTap: () {}),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff120D26)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text('Sign in',
                          style: TextStyle(
                            color: Color(0xff5669FF),
                            fontSize: 14,
                          )),
                    )
                  ],
                )
              ],
            ),
          )),
        )));
  }
}
