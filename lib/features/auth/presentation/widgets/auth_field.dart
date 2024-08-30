// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  AuthField({super.key, required this.hintText, required this.controller, this.isobscureText=false});
  String hintText;
  final TextEditingController controller;
  final bool isobscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        
        hintText: hintText,
      ),
      obscureText: isobscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is missing!';
        }
        return null;
      },
    );
  }
}
