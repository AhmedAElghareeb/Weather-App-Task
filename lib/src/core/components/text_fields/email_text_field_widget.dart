import 'package:base_structure/src/core/components/text_fields/app_text_field_widget.dart';
import 'package:base_structure/src/core/helpers/validation_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Email Optional Text Field Widget
class EmailOptionalTextFieldWidget extends StatefulWidget {
  const EmailOptionalTextFieldWidget({
    super.key,
    required this.controller,
    this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  State<EmailOptionalTextFieldWidget> createState() =>
      _EmailOptionalTextFieldWidgetState();
}

class _EmailOptionalTextFieldWidgetState
    extends State<EmailOptionalTextFieldWidget> {
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
    } else if (widget.controller.text.isEmpty &&
        _autovalidateMode != AutovalidateMode.disabled) {
      setState(() {
        _autovalidateMode = AutovalidateMode.disabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFieldWidget(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.emailAddress,
      validator: Validators.validateEmailOptional,
      autovalidateMode: _autovalidateMode,
      // title: 'textFieldData.email'.tr(),
      // label: 'textFieldData.email'.tr(),
      hint: 'textFieldData.email'.tr(),
      // suffixIcon: SvgImageWidget(image: 'email'.addIconAsset()),
      // prefixIcon: SvgImageWidget(image: 'email'.addIconAsset()),
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }
}

/// Email Required Text Field Widget
class EmailRequiredTextFieldWidget extends StatefulWidget {
  const EmailRequiredTextFieldWidget({
    super.key,
    required this.controller,
    this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  State<EmailRequiredTextFieldWidget> createState() =>
      _EmailRequiredTextFieldWidgetState();
}

class _EmailRequiredTextFieldWidgetState
    extends State<EmailRequiredTextFieldWidget> {
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
    } else if (widget.controller.text.isEmpty &&
        _autovalidateMode != AutovalidateMode.disabled) {
      setState(() {
        _autovalidateMode = AutovalidateMode.disabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFieldWidget(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.emailAddress,
      validator: Validators.validateEmail,
      autovalidateMode: _autovalidateMode,
      // title: 'textFieldData.email'.tr(),
      // label: 'textFieldData.email'.tr(),
      hint: 'textFieldData.email'.tr(),
      // suffixIcon: SvgImageWidget(image: 'email'.addIconAsset()),
      // prefixIcon: SvgImageWidget(image: 'email'.addIconAsset()),
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }
}
