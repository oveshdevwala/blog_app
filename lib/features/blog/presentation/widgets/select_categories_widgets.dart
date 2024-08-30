// ignore_for_file: must_be_immutable

import 'package:clean_architecture_tdd/core/const/constants.dart';
import 'package:clean_architecture_tdd/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SelectCategoriesWidgets extends StatefulWidget {
  SelectCategoriesWidgets({super.key, required this.selectedTopic});
  List<String> selectedTopic;

  @override
  State<SelectCategoriesWidgets> createState() =>
      _SelectCategoriesWidgetsState();
}

class _SelectCategoriesWidgetsState extends State<SelectCategoriesWidgets> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: Constants.topics2
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    if (widget.selectedTopic.contains(e)) {
                      widget.selectedTopic.remove(e);
                    } else {
                      widget.selectedTopic.add(e);
                    }
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Chip(
                      backgroundColor: widget.selectedTopic.contains(e)
                          ? AppPallete.gradient1
                          : AppPallete.backgroundColor,
                      side: BorderSide(
                          color: widget.selectedTopic.contains(e)
                              ? AppPallete.transparentColor
                              : AppPallete.borderColor),
                      label: Text(e),
                      labelStyle: TextStyle(
                          color: widget.selectedTopic.contains(e)
                              ? AppPallete.whiteColor
                              : AppPallete.greyColor),
                    ),
                  ),
                ),
              )
              .toList()),
    );
  }
}
