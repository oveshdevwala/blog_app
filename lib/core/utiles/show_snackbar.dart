import 'package:clean_architecture_tdd/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
        content: Text(
      content.toString(),
      style: const TextStyle(fontSize: 15, color: AppPallete.gradient2),
    )));
}
