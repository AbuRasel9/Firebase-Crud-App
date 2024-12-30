import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:pinput/pinput.dart';
import 'package:test_cli/widget/button.dart';

class VerifyOtpDialog extends StatefulWidget {
  final void Function(String) onOtpEntered;

  VerifyOtpDialog({required this.onOtpEntered});

  @override
  _VerifyOtpDialogState createState() => _VerifyOtpDialogState();
}

class _VerifyOtpDialogState extends State<VerifyOtpDialog> with CodeAutoFill {
  String otpCode = "";

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
    });
    widget.onOtpEntered(otpCode);
  }

  @override
  void initState() {
    super.initState();
    listenForCode();
  }

  @override
  void dispose() {
    cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Verify OTP'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Enter the 4-digit code sent to your number.'),
          const SizedBox(height: 16),
          Pinput(
            length: 4,
            defaultPinTheme: PinTheme(
              height: 50,
              width: 50,
              textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onCompleted: widget.onOtpEntered,
            controller: TextEditingController(text: otpCode),
          ),
        ],
      ),
      actions: [
        Row(
          children: <Widget>[
            Expanded(
              child: ButtonWidget(
                buttonText: "Cancel",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: ButtonWidget(
                buttonText: "Verify",
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
