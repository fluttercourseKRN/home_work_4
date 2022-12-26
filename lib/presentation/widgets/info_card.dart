import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Widget> items;
  @override
  Widget build(BuildContext context) {
    return Card(
      // shape: Border.all(),
      elevation: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items,
      ),
    );
  }
}
