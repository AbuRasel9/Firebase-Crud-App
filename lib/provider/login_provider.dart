import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_cli/model/user_model.dart';
import 'package:test_cli/ui/home/home_screen.dart';
import 'package:test_cli/utils/utils.dart';
import 'package:test_cli/widget/verify_otp_dialog.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> login(UserModel user, BuildContext context) async {

    try {
      setLoading(true);
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: user.email ?? "", password: user.password ?? "");

      if (userCredential.user != null) {
        Utils().toastMessage(
          "Login Successfull",
          Colors.green,
          Colors.white,
        );

        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>  HomeScreen(uid: _auth.currentUser?.uid ?? "",),
          ),
              (route) => false,
        );
        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      } else {
        Utils().toastMessage(
          "Login Failed",
          Colors.red,
          Colors.white,
        );
      }

      setLoading(false);
    } on FirebaseAuthException catch (e) {

      String message;
      switch (e.code) {
        case "invalid-credential":
          message = "Invalid user Name or Password";
        case 'user-not-found':
          message = "No user found for this email.";
          break;
        case 'wrong-password':
          message = "Incorrect password.";
          break;
        case 'invalid-email':
          message = "Invalid email format.";
          break;
        default:
          message = "An unexpected error occurred. Please try again.";
      }
      setLoading(false);

      Utils().toastMessage(
        message,
        Colors.red,
        Colors.white,
      );
    } catch (e) {
      setLoading(false);
      Utils().toastMessage(
        "Login Failed",
        Colors.red,
        Colors.white,
      );
    }
  }

  Future<void> registration(UserModel user, BuildContext context) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
          email: user.email ?? "", password: user.password ?? "");
      if (userCredential.user != null) {
        Utils().toastMessage(
          "Registration Successfull",
          Colors.green,
          Colors.white,
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = "This email is already registered.";
          break;
        case 'weak-password':
          message = "Password should be at least 6 characters.";
          break;
        case 'invalid-email':
          message = "Invalid email format.";
          break;
        default:
          message = "Something went wrong.";
      }
      setLoading(false);

      Utils().toastMessage(
        message,
        Colors.red,
        Colors.white,
      );
    } catch (e) {
      Utils().toastMessage(
        "Registration Failed",
        Colors.red,
        Colors.white,
      );
      setLoading(false);
    }
  }

  Future<void> verifyPhoneNumber(String phoneNumber,
      BuildContext context) async {
    setLoading(true);

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (phoneAuthCredential) {
            setLoading(false);
          },
          verificationFailed: (error) {
            setLoading(false);

            Utils().toastMessage(error.toString(), Colors.red, Colors.white,);
          },
          codeSent: (verificationId, forceResendingToken) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return  VerifyOtpDialog(verificationId: verificationId);
              },
            );

          },
          codeAutoRetrievalTimeout: (error) {

            Utils().toastMessage(error.toString(), Colors.red, Colors.white,);
            setLoading(false);

          },);
    } on FirebaseAuthException catch (e) {
      String message = Utils().getOtpErrorMessage(e.code);


      setLoading(false);
      Utils().toastMessage(message, Colors.red, Colors.white);
    } catch (e) {
      setLoading(false);

      Utils().toastMessage("Something went to wrong", Colors.red, Colors.white);
    }
  }

// void verifyPhoneNumber(String phoneNumber,BuildContext context) async {
//   try {
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: phoneNumber.trim(),
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         // Auto sign-in on Android
//         await FirebaseAuth.instance.signInWithCredential(credential);
//         print("Auto login successful");
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         String message = Utils().getOtpErrorMessage(e.code);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         setState(() {
//           _verificationId = verificationId;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("OTP sent to your phone.")));
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         _verificationId = verificationId;
//       },
//     );
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An unexpected error occurred.")));
//     print("Error: $e");
//   }
// }
}
