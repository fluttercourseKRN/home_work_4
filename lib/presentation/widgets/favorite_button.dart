import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.onTap,
    required this.value,
  }) : super(key: key);

  final void Function() onTap;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ;
      },
      icon: value
          ? const Icon(Icons.star, color: Colors.orange)
          : const Icon(Icons.star_border),
    );
  }
}
