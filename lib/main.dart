import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pixfyapp/firebase_options.dart';
import 'package:pixfyapp/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'info.dart';
import 'package:pixfyapp/view/splashscreen.dart';

import 'homescreen.dart';
import 'auth/login.dart';
import 'auth/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('==============User is currently signed out!');
      } else {
        print('====================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) {
        final provider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          theme: provider.Theme,
          home: SplashView(),
          routes: {
            "signup": (context) => SignUp(),
            "login": (context) => Login(),
            "home": (context) => HomeScreen(),
            "info": (context) => Info(),
          
          },
        );
      },
    );
  }
}
