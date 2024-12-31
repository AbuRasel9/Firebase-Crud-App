import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_cli/provider/data_provider.dart';
import 'package:test_cli/provider/login_provider.dart';
import 'package:test_cli/ui/splash_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ), ChangeNotifierProvider(
          create: (context) => DataProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepPurple,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
