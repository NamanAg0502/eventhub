import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextAreaInput extends StatefulWidget {
  final IconData prefixIcon;
  final String label;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final int lines;

  const CustomTextAreaInput({
    super.key,
    required this.prefixIcon,
    this.lines = 5,
    required this.label,
    this.isPassword = false,
    this.onChanged,
    required this.controller,
  });

  @override
  _CustomTextAreaInputState createState() => _CustomTextAreaInputState();
}

class _CustomTextAreaInputState extends State<CustomTextAreaInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        maxLines: widget.lines,
        controller: widget.controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(widget.prefixIcon, color: const Color(0xff807A7A)),
          hintText: widget.label,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
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
