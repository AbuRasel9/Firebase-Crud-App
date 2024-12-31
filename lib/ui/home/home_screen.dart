import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_cli/provider/data_provider.dart';
import 'package:test_cli/ui/auth/login_screen.dart';
import 'package:test_cli/ui/home/widget/add_data_dialog.dart';
import 'package:test_cli/utils/utils.dart';

import '../../widget/verify_otp_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.uid});

  final String uid;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    context.read<DataProvider>().getData(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    print("---------------------${jsonEncode(dataProvider.data)}");
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
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AddDataDialog(
                uid: widget.uid,
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: dataProvider.data.isEmpty
                ? const Center(child: Text('No data found'))
                : ListView.builder(
                    itemCount: dataProvider.data.length,
                    itemBuilder: (context, index) {
                      final info = dataProvider.data[index];
                      
                      return ListTile(
                        title: Text(info.name ?? ""),
                        subtitle: Text("${info.email}, ${info.address}"),
                        trailing: Text(info.id ?? ""),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
