import 'package:flutter/material.dart';

class EditIconButton extends StatelessWidget {
  const EditIconButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: const Icon(Icons.edit_calendar),
      color: Colors.orange,
    );
  }
}
