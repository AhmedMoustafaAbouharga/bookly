import 'package:bookly/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      required this.backgroundColor,
      required this.textColor,
      this.borderRadius,
      this.fontSize})
      : super(key: key);
  final String text;
  final Color backgroundColor;

  final Color textColor;

  final double? fontSize;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(12)),
          ),
          child: Text(
            text,
            style: Styles.textStyle18.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          )),
    );
  }
}
