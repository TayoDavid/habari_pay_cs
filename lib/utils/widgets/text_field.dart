import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.hint,
    this.height,
    this.onChange,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.focus,
    this.inputAction,
    this.inputType,
    this.suffix,
    this.prefix,
    this.obscure = false,
    this.textSize,
    this.borderRadius,
    this.focusNode,
    this.formatters,
    this.margin,
    this.hasBorder = true,
    this.validator,
    required this.controller,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;

  final String? hint;
  final bool? focus;
  final bool obscure;
  final int maxLines;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final Function(String?)? onChange;
  final Function(String)? onFieldSubmitted;
  final Widget? suffix;
  final Widget? prefix;
  final double? textSize;
  final BorderRadius? borderRadius;
  final double? height;
  final List<TextInputFormatter>? formatters;
  final EdgeInsets? margin;
  final bool hasBorder;
  final FormFieldValidator<String>? validator;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  BorderRadius get kBorderRadius => BorderRadius.circular(16);
  Color get kStrokeColor => Color(0xFFE8E8E8);

  late double height;

  @override
  void initState() {
    super.initState();
    height = widget.height ?? 48;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: widget.margin ?? EdgeInsets.only(bottom: 16),
      height: height,
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        textInputAction: widget.inputAction,
        keyboardType: widget.inputType,
        onChanged: widget.onChange,
        obscureText: widget.obscure,
        maxLines: widget.maxLines,
        onFieldSubmitted: widget.onFieldSubmitted,
        cursorHeight: 18,
        cursorColor: Colors.black87,
        inputFormatters: widget.formatters,
        scrollPadding: EdgeInsets.zero,
        validator: (value) {
          final response = widget.validator?.call(widget.controller.text);
          if (response != null) {
            setState(() => height += 20.0);
          }
          debugPrint("Response is: $response");
          return response;
        },
        style: TextStyle(
          color: Colors.black87,
          fontSize: widget.textSize ?? 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          suffixIcon: widget.suffix,
          prefixIcon: widget.prefix,
          suffixStyle: TextStyle(color: Colors.black87),
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: widget.textSize ?? 14,
            fontWeight: FontWeight.w500,
          ),
          border: widget.hasBorder
              ? OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? kBorderRadius,
                  borderSide: BorderSide(color: kStrokeColor, width: 1.5),
                )
              : OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? kBorderRadius,
                  borderSide: BorderSide.none,
                ),
          focusedBorder: widget.hasBorder
              ? OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? kBorderRadius,
                  borderSide: BorderSide(color: Colors.black87, width: 1.5),
                )
              : OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? kBorderRadius,
                  borderSide: BorderSide.none,
                ),
          errorBorder: widget.hasBorder
              ? OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? kBorderRadius,
                  borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
                )
              : OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? kBorderRadius,
                  borderSide: BorderSide.none,
                ),
        ).applyDefaults(InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        )),
      ),
    );
  }
}
