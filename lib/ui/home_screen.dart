import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_cli/ui/auth/login_screen.dart';
import 'package:test_cli/utils/utils.dart';

import '../widget/verify_otp_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await _auth.signOut().then(
                  (value) {
                    Utils().toastMessage(
                      "Logout Successfull",
                      Colors.green,
                      Colors.white,
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                          (route) => false,
                    );
                  },
                );
              } catch (e) {
                Utils().toastMessage(
                  "Logout Failed",
                  Colors.red,
                  Colors.white,
                );
              }
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {

        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: const Column(
        children: <Widget>[],
      ),
    );
  }
}
