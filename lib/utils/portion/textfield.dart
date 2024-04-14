import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/controller/validator.dart';
import '../const/colors.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget Function(BuildContext context,
      {int? currentLength, int? maxLength, bool? isFocused})? buildCounter;

  final IconData? icon;

  const MyTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.icon,
    this.validator,
    this.labelText,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.buildCounter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.0112,
          horizontal: MediaQuery.of(context).size.width * 0.04),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        buildCounter: buildCounter,
        decoration: InputDecoration(
          labelText: labelText ?? hintText,
          hintText: hintText,
          filled: true,
          fillColor: CustomColor.secondarybackgroundColor,
          suffixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CustomColor.mainColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
        ],
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const PasswordTextField({
    super.key,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.hintText,
    this.labelText,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.0112,
          horizontal: MediaQuery.of(context).size.width * 0.04),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        obscureText: obscureText,
        validator: (value) => InputValidators.validatePassword(value),
        decoration: InputDecoration(
          labelText: widget.labelText ?? widget.hintText ?? 'Password',
          hintText: widget.hintText ?? 'Password',
          filled: true,
          fillColor: CustomColor.secondarybackgroundColor,
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CustomColor.mainColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
