import 'package:flutter/material.dart';

import '../styles/colors.dart';

Widget DefaultTextFormField(
        {required TextEditingController controller,
        required String? validateText,
        bool obSecure = false,
        Widget? suffixIconWidget,
        required FormFieldValidator<String>? validator,
        required String? hintText}) =>
    TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      validator: validator,
      onFieldSubmitted: (String value) {
        controller.text = value;
      },
      obscureText: obSecure,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColor.textFormFieldTextColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColor.textFormFieldBorderColor,
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        fillColor: AppColor.textFormFieldFillColor,
        filled: true,
        labelStyle: const TextStyle(
          color: Color(0xff707070),
        ),
        suffixIcon: suffixIconWidget,
      ),
    );
