import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    Key? key,
    required this.controller,
    this.labelText,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.minLine = 1,
    this.maxLine = 1,
  }) : super(key: key);

  final int minLine;
  final int maxLine;
  final TextEditingController controller;
  final String? labelText;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLine,
      maxLines: maxLine,
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
      controller: controller,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      textInputAction: textInputAction,
      validator: validator,
    );
  }
}
