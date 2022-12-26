import 'package:flutter/material.dart';

class LabelValue extends StatelessWidget {
  const LabelValue({
    Key? key,
    required this.label,
    required this.text,
  }) : super(key: key);

  final String label;
  final String text;
  @override
  Widget build(BuildContext context) {
    final mainColor = Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: mainColor,
              fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
