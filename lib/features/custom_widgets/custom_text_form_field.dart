import 'package:flutter/material.dart';
import '../../config/resources/text_styles/app_text_styles.dart';

Widget customTextFormField({
  TextEditingController? controller,
  String? hintText,
  bool? readOnly,
  void Function()? onTap,
  Widget? suffix,
  IconData? prefixIcon,
  String? Function(String?)? validator,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        validator: validator,
        readOnly: readOnly??false,
        style: AppTextStyles().bodyText1,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles().bodyText3,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 11, horizontal: 15),
          isDense: true,
            suffixIconConstraints: const BoxConstraints(maxHeight: 24, maxWidth: 24),
            prefixIconConstraints: const BoxConstraints(minHeight: 24, minWidth: 24),
            suffixIcon: suffix,
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 5.0,right: 10),
                    child: Icon(
                      prefixIcon,
                      color: const Color(0xff1DA1F2),
                      size: 22,
                    ),
                  )
                : null,
            enabledBorder: plainBorder,
            border: plainBorder,
            disabledBorder: plainBorder,
            errorBorder: plainBorder,
            focusedErrorBorder: plainBorder,
            focusedBorder: plainBorder,),
      ),
    );

InputBorder? plainBorder = OutlineInputBorder(
  borderSide: const BorderSide(width: 1, color: Color(0xffE5E5E5)),
  borderRadius: BorderRadius.circular(4.0),
);
