import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    this.controller,
    this.hintText = "",
    this.color,
    this.formatters = const [],
    this.keyboardType,
    this.action,
    super.key,
  });

  final TextEditingController? controller;
  final String hintText;
  final Color? color;
  final List<TextInputFormatter> formatters;
  final TextInputType? keyboardType;
  final TextInputAction? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(32),
      ),
      child: TextField(
        style: TextStyle(
          fontSize: 14.0,
          color: color ?? Colors.black,
        ),
        controller: controller,
        inputFormatters: formatters,
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: action ?? TextInputAction.done,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.0,
            color: Colors.grey.shade400,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
