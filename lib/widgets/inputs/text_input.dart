import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final IconData prefixIcon;
  final String label;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;

  const CustomTextInput({
    super.key,
    required this.prefixIcon,
    required this.label,
    this.isPassword = false,
    this.onChanged,
    required this.controller,
  });

  @override
  _CustomTextInputState createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        controller: widget.controller,
        cursorColor: Colors.grey[700],
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(widget.prefixIcon, color: const Color(0xff807A7A)),
          hintText: widget.label,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? CupertinoIcons.eye_fill
                        : CupertinoIcons.eye_slash_fill,
                    color: const Color(0xff807A7A),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
      ),
    );
  }
}
