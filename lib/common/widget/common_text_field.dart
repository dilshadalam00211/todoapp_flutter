import 'package:flutter/material.dart';
import 'package:flutter_todo/style/app_colors.dart';
import 'package:flutter_todo/style/app_text_style.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    Key? key,
    required this.labelText,
    this.suffixIcon = const SizedBox.shrink(),
    required this.onChanged,
    this.validator,
    this.onTap,
    required this.textEditingController,
    this.isValidateField = true,
    this.isReadOnly = false,
    this.autoFocus = false,
    this.prefixText = '',
    this.maxLines = 1
  }) : super(key: key);

  final String labelText;
  final VoidCallback? onTap;
  final Widget suffixIcon;
  final Function(String) onChanged;
  final bool autoFocus;
  final bool isValidateField;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final bool isReadOnly;
  final int maxLines;
  final String prefixText;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: TextFormField(
        onTap: widget.onTap,
        controller: widget.textEditingController,
        focusNode: myFocusNode,
        autofocus: widget.autoFocus,
        style: AppTextStyle.textFieldFont,
        decoration: InputDecoration(
            suffixIconConstraints: const BoxConstraints(minHeight: 24, minWidth: 24),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.disabledBorderColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.buttonBorderColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.errorBorderColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            label: Text(
              widget.labelText,
              style: const TextStyle(fontSize: 16),
            ),
            labelStyle: AppTextStyle.textFieldLabelStyle.copyWith(
              color: !widget.isValidateField
                  ? Colors.red
                  : myFocusNode.hasFocus
                  ? AppColors.buttonBorderColor
                  : AppColors.disabledBorderColor,
            ),
            errorStyle: AppTextStyle.textFieldLabelStyle.copyWith(
              color: AppColors.errorBorderColor,
            ),
            isDense: true,
            errorMaxLines: 3,
            suffixIcon: widget.suffixIcon,
            prefixText: widget.prefixText),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: AppColors.textFieldFontColor,
        maxLines: widget.maxLines,
        validator: widget.validator,
        onChanged: widget.onChanged,
        readOnly: widget.isReadOnly,
      ),
    );
  }
}
