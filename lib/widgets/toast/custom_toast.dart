import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  final dynamic message;
  final bool isError;

  const CustomToast({super.key, required this.message, this.isError = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isError ? Colors.red : Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              message.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ));
  }
}

void showToast(BuildContext context, dynamic message, {bool isError = false}) {
  final toastWidget = CustomToast(message: message, isError: isError);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: toastWidget,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
