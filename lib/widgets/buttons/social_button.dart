import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onTap;

  const SocialLoginButton({
    required this.text,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffD3D4E2).withOpacity(0.25), // Shadow color
              spreadRadius: 0, // Spread radius
              blurRadius: 30, // Blur radius
              offset: const Offset(15, 0), // Shadow offset
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.white, // Background color of the button
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(12.0), // Rounded border radius
            ),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 24.0,
                width: 24.0,
              ),
              const SizedBox(width: 20.0),
              Text(
                text,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
        ));
  }
}
