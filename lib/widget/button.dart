import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final Color? color;

  const ButtonWidget(
      {super.key, required this.buttonText, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
          backgroundColor: color ?? Colors.deepPurple,
        ),
        onPressed: onTap,
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
