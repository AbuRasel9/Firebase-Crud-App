import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_cli/provider/login_provider.dart';
import 'package:test_cli/widget/button.dart';

import '../../widget/verify_otp_dialog.dart';

class PhoneNumberAuthScreen extends StatefulWidget {
  const PhoneNumberAuthScreen({super.key});

  @override
  State<PhoneNumberAuthScreen> createState() => _PhoneNumberAuthScreenState();
}

class _PhoneNumberAuthScreenState extends State<PhoneNumberAuthScreen> {
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Login With Phone Number",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a password.";
                  } else if (value.length < 6) {
                    return "Password must be at least 6 characters long.";
                  }

                  return null;
                },
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: 15,
                    ),
                    border: OutlineInputBorder(),
                    labelText: "Enter Phone number"),
              ),
              const SizedBox(
                height: 30,
              ),
              authProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ButtonWidget(
                      buttonText: "Next",
                      onTap: () {
                        authProvider.verifyPhoneNumber(
                            _phoneController.text, context);
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
