import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  const BlogEditor(
      {super.key,
      required this.controller,
      required this.hint,
      this.miniLine = 7});
  final TextEditingController controller;
  final String hint;
  final int miniLine;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hint,),
      maxLines: null,
      minLines: miniLine,
      
      validator: (value) {
        if (value!.trim().isEmpty) {
          return '$hint is missing!';
        }
        return null;
      },
    );
  }
}
