// ignore_for_file: must_be_immutable

import 'package:clean_architecture_tdd/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthGradientButton extends StatelessWidget {
  AuthGradientButton({
    super.key,
    required this.onTap,
    required this.btName,
    this.widget,
  });
  VoidCallback onTap;
  String btName;
  Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          gradient: const LinearGradient(colors: [
            AppPallete.gradient1,
            AppPallete.gradient2,
            AppPallete.gradient3,
          ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              fixedSize: Size(390.w, 55.h),
              backgroundColor: AppPallete.transparentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7))),
          child: widget ??
              Text(
                btName,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              )),
    );
  }
}
