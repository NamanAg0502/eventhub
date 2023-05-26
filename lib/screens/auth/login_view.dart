import 'package:appwrite/appwrite.dart';
import 'package:eventhub/main.dart';
import 'package:eventhub/widgets/buttons/navigate_button.dart';
import 'package:eventhub/widgets/buttons/social_button.dart';
import 'package:eventhub/widgets/inputs/text_input.dart';
import 'package:eventhub/widgets/toast/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = true;

  void login() async {
    // Store the "Remember Me" status
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', rememberMe);
    await prefs.setBool('login', true);
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    checkRememberMeStatus();
    checkLoginStatus();
  }

  Future<void> checkRememberMeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMeStatus = prefs.getBool('rememberMe') ?? false;

    setState(() {
      rememberMe = rememberMeStatus;
    });
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loginStatus = prefs.getBool('login') ?? false;

    print(loginStatus);

    if (loginStatus) {
      _navigateToHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    final client = AppwriteProvider.of(context)!.client;
    Account account = Account(client);
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void loginUser() {
      account
          .createEmailSession(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        login();
        Navigator.pushReplacementNamed(context, '/home');
        showToast(context, 'Login Successful');
      }).catchError((error) {
        print(error);
        showToast(context, error.message);
      });
    }

    void signInWithGoogle() {
      account
          .createOAuth2Session(provider: 'google', success: '')
          .then((value) {
        login();
        Navigator.pushNamed(context, '/home');
      }).catchError((error) {
        print(error);
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
                Column(
                  children: [
                    Image.asset(
                      'assets/images/logo/logo.png',
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'EventHub',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff37364A)),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff120D26)),
                      ),
                      const SizedBox(height: 20),
                      CustomTextInput(
                          controller: emailController,
                          prefixIcon: CupertinoIcons.mail,
                          label: 'abc@email.com'),
                      const SizedBox(height: 20),
                      CustomTextInput(
                          controller: passwordController,
                          prefixIcon: CupertinoIcons.lock,
                          label: 'password',
                          isPassword: true),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Transform.scale(
                                scale: 0.6,
                                child: CupertinoSwitch(
                                  value: rememberMe,
                                  onChanged: (bool value) {
                                    setState(() {
                                      rememberMe = value;
                                    });
                                  },
                                  activeColor: const Color(0xff5669FF),
                                ),
                              ),
                              const Text('Remember me',
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xff120D26)))
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Forgot password?',
                                style: TextStyle(
                                  color: Color(0xff5669FF),
                                  fontSize: 14,
                                )),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: NavigateButton(
                            label: 'SIGN IN',
                            icon: CupertinoIcons.arrow_right,
                            onTap: loginUser),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
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
                        onTap: signInWithGoogle),
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
                      'Don\'t have an account?',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff120D26)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text('Sign up',
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
