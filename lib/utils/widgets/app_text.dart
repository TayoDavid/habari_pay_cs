import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.color,
    this.align,
    this.size,
    this.weight,
    this.spacing,
    this.height,
    this.maxLines,
    this.overflow,
    this.underline,
    this.textStyle,
    this.fontFamily,
  });

  final String text;
  final Color? color;
  final TextAlign? align;
  final double? size;
  final FontWeight? weight;
  final double? spacing;
  final double? height;
  final int? maxLines;
  final String? fontFamily;
  final TextOverflow? overflow;
  final TextDecoration? underline;
  final TextStyle? textStyle;

  TextStyle get style {
    if (textStyle != null) {
      return textStyle!.copyWith(
        height: height,
        fontSize: size,
        letterSpacing: spacing,
        color: color,
        fontWeight: weight,
        decoration: underline,
      );
    }

    return TextStyle(
      height: height,
      fontSize: size ?? 16,
      letterSpacing: spacing,
      color: color,
      fontFamily: fontFamily,
      fontWeight: weight ?? FontWeight.w400,
      decoration: underline ?? TextDecoration.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow,
      style: style,
    );
  }
}
