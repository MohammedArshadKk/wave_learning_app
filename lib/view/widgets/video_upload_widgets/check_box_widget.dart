import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class CheckBoxWidget extends StatefulWidget {
  const CheckBoxWidget({super.key});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool _isCheckedFree = false;
  bool _isCheckedPaid = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Checkbox(
                value: _isCheckedFree,
                onChanged: (bool? newValue) {
                  setState(() {
                    _isCheckedFree = newValue!;
                    _isCheckedPaid=false; 
                  });
                },
                activeColor: AppColors.primaryColor,
              ),
              CustomText(
                  text: "Free",
                  color: AppColors.secondaryColor,
                  fontSize: 18,
                  fontFamily: Fonts.labelText,
                  fontWeight: FontWeight.normal),
            ],
          ),
          const SizedBox(
            width: 100,
          ),
          Row(
            children: [
              Checkbox(
                value: _isCheckedPaid,
                onChanged: (bool? newValue) {
                  setState(() {
                    _isCheckedPaid = newValue!;
                    _isCheckedFree=false;
                  });
                },
                activeColor: AppColors.primaryColor,
              ),
              
              CustomText(
                  text: "Paid", 
                  color: AppColors.secondaryColor,
                  fontSize: 18,
                  fontFamily: Fonts.labelText,
                  fontWeight: FontWeight.normal),
            ],
          )
        ],
      ),
    );
  }
}
