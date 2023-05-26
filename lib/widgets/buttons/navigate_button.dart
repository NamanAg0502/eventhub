import 'package:flutter/material.dart';

class NavigateButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const NavigateButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff6F7EC9).withOpacity(0.25), // Shadow color
            spreadRadius: 0, // Spread radius
            blurRadius: 35, // Blur radius
            offset: const Offset(0, 10), // Shadow offset
          ),
        ],
      ),
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor:
                const Color(0xff5669FF), // Background color of the button
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(15.0), // Rounded border radius
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text(
                  label,
                  style: const TextStyle(fontSize: 16),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(
                        0xff3D56F0), // Background color behind the arrow
                    borderRadius:
                        BorderRadius.circular(13.0), // Rounded border radius
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    icon,
                    size: 12,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
