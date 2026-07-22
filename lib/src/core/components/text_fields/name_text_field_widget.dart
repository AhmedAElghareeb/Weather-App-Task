import 'package:base_structure/src/core/components/text_fields/app_text_field_widget.dart';
import 'package:base_structure/src/core/helpers/validation_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Full Name
class NameTextFieldWidget extends StatefulWidget {
  const NameTextFieldWidget({
    super.key,
    required this.controller,
    this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  State<NameTextFieldWidget> createState() => _NameTextFieldWidgetState();
}

class _NameTextFieldWidgetState extends State<NameTextFieldWidget> {
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
      keyboardType: TextInputType.name,
      autovalidateMode: _autovalidateMode,
      validator: Validators.validateFullName,
      // title: 'textFieldData.fullName'.tr(),
      // label: 'textFieldData.fullName'.tr(),
      hint: 'textFieldData.fullName'.tr(),
      // suffixIcon: SvgImageWidget(image: 'person'.addIconAsset()),
      // prefixIcon: SvgImageWidget(image: 'person'.addIconAsset()),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s\u0600-\u06FF]')),
      ],
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }
}

/// First Name
class FirstNameTextFieldWidget extends StatefulWidget {
  const FirstNameTextFieldWidget({
    super.key,
    required this.controller,
    this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  State<FirstNameTextFieldWidget> createState() =>
      _FirstNameTextFieldWidgetState();
}

class _FirstNameTextFieldWidgetState extends State<FirstNameTextFieldWidget> {
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
      keyboardType: TextInputType.name,
      autovalidateMode: _autovalidateMode,
      validator: Validators.validateFirstName,
      // title: 'textFieldData.firstName'.tr(),
      // label: 'textFieldData.firstName'.tr(),
      hint: 'textFieldData.firstName'.tr(),
      // suffixIcon: SvgImageWidget(image: 'person'.addIconAsset()),
      // prefixIcon: SvgImageWidget(image: 'person'.addIconAsset()),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s\u0600-\u06FF]')),
      ],
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }
}

/// Last Name
class LastNameTextFieldWidget extends StatefulWidget {
  const LastNameTextFieldWidget({
    super.key,
    required this.controller,
    this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  State<LastNameTextFieldWidget> createState() =>
      _LastNameTextFieldWidgetState();
}

class _LastNameTextFieldWidgetState extends State<LastNameTextFieldWidget> {
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
      keyboardType: TextInputType.name,
      autovalidateMode: _autovalidateMode,
      validator: Validators.validateLastName,
      // title: 'textFieldData.lastName'.tr(),
      // label: 'textFieldData.lastName'.tr(),
      hint: 'textFieldData.lastName'.tr(),
      // suffixIcon: SvgImageWidget(image: 'person'.addIconAsset()),
      // prefixIcon: SvgImageWidget(image: 'person'.addIconAsset()),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s\u0600-\u06FF]')),
      ],
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }
}
