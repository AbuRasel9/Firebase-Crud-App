import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_cli/ui/splash_screen.dart';

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
    return  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple

      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
