import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_cli/model/user_model.dart';
import 'package:test_cli/provider/login_provider.dart';
import 'package:test_cli/ui/auth/login_screen.dart';
import 'package:test_cli/utils/utils.dart';
import 'package:test_cli/widget/button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _showPassword = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  // Future<void> registerUser() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       setState(() {
  //         _isLoading = true;
  //       });
  //
  //           await _auth.createUserWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim(),
  //       );
  //       setState(() {
  //         _isLoading = false;
  //       });
  //
  //       // Additional steps like storing the user's name and phone in Firestore can be done here.
  //
  //       Utils().toastMessage("Registration Successfull",Colors.greenAccent,Colors.white);
  //
  //       // Navigate to another page or clear inputs.
  //     } catch (e) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       Utils().toastMessage(e.toString(),Colors.red,Colors.white);
  //
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return "Enter Email";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    labelText: "Enter Email",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.text,
                obscureText: _showPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a password.";
                  } else if (value.length < 6) {
                    return "Password must be at least 6 characters long.";
                  }

                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Enter Password",
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(
                        () {
                          _showPassword = !_showPassword;
                        },
                      );
                    },
                    child: Icon(_showPassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              authProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ButtonWidget(
                      buttonText: "Signup",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          authProvider.registration(UserModel(email: _emailController.text,password: _passwordController.text), context).then((value) {
                            _emailController.clear();
                            _passwordController.clear();
                          },);

                        }
                      },
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Don't Have Account?"),
                  TextButton(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          ),
                      child: const Text("Login"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
