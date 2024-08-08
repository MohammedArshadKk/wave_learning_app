import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.labelText,
      required this.fontFamily,
      required this.fontWeight,
      required this.padding,
      required this.fontSize,
      required this.textColor,
      required this.paddingForm,
      required this.borderRadius,
      this.color = Colors.white,
      required this.controller,
      this.validator});
  final String labelText;
  final String fontFamily;
  final FontWeight fontWeight;
  final double padding;
  final double fontSize;
  final Color textColor;
  final double paddingForm;
  final double borderRadius;
  final Color color;
  final TextEditingController controller;
  final FormFieldValidator<String?>? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingForm),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: null,
        decoration: InputDecoration(
            filled: true,
            fillColor: color,
            label: Padding(
              padding: EdgeInsets.all(padding),
              child: CustomText(
                  text: labelText,
                  color: textColor,
                  fontSize: fontSize,
                  fontFamily: fontFamily,
                  fontWeight: fontWeight),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius))),
      ),
    );
  }
}