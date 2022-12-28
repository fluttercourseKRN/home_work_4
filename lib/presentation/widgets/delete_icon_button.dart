import 'package:flutter/material.dart';

class DeleteIconButton extends StatelessWidget {
  const DeleteIconButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: const Icon(Icons.delete_outline),
      color: Theme.of(context).colorScheme.error,
    );
  }
}
