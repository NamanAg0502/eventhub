import 'package:eventhub/screens/auth/login_view.dart';
import 'package:eventhub/screens/auth/register_view.dart';
import 'package:eventhub/screens/event/create_event.dart';
import 'package:eventhub/screens/menu/explore_screen.dart';
import 'package:eventhub/screens/menu/home_screen.dart';
import 'package:eventhub/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:appwrite/appwrite.dart';

void main() {
  // For self signed certificates, only use for development
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          Brightness.dark, // Replace with your desired color
    ),
  );
  runApp(const MyApp());
}

class AppwriteProvider extends InheritedWidget {
  final Client client;

  const AppwriteProvider(
      {super.key, required this.client, required Widget child})
      : super(child: child);

  static AppwriteProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppwriteProvider>();
  }

  @override
  bool updateShouldNotify(covariant AppwriteProvider oldWidget) {
    return client != oldWidget.client;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // For self signed certificates, only use for development
    final Client client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('646cba8d06727235a02a')
        .setSelfSigned(status: true);

    return AppwriteProvider(
        client: client,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'EventHub',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
          home: const SplashScreen(),
          routes: {
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/home': (context) => const HomeScreen(),
            '/explore': (context) => const ExploreScreen(),
            '/create-event': (context) => const CreateEventScreen(),
          },
        ));
  }
}
