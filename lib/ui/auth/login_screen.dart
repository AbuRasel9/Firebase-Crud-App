import 'package:flutter/material.dart';
import 'package:test_cli/widget/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
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
                  if (value?.isEmpty ?? false) {
                    return "Enter Password";
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
              ButtonWidget(buttonText: "Login", onTap: () {
                if(_formKey.currentState!.validate()){
                  
                }


              })
            ],
          ),
        ),
      ),
    );
  }
}
