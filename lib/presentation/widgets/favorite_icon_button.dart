import 'package:flutter/material.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    Key? key,
    required this.onTap,
    required this.value,
  }) : super(key: key);

  final void Function() onTap;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: value
          ? const Icon(Icons.star, color: Colors.orange)
          : const Icon(Icons.star_border),
    );
  }
}
