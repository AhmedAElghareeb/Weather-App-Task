import 'package:base_structure/src/core/components/text_fields/app_text_field_widget.dart';
import 'package:base_structure/src/core/helpers/validation_helper.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  const PasswordTextFieldWidget({
    super.key,
    required this.controller,
    this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool _obscureText = true;

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (widget.controller.text.isNotEmpty &&
        _autovalidateMode == AutovalidateMode.disabled) {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFieldWidget(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      validator: Validators.validatePassword,
      autovalidateMode: _autovalidateMode,
      // title: 'textFieldData.password'.tr(),
      // label: 'textFieldData.password'.tr(),
      hint: 'textFieldData.password'.tr(),
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: AppColors.black,
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }
}
