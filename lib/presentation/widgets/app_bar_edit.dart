import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobsin/presentation/model/constants.dart';

class AppBarEdit extends StatelessWidget implements PreferredSizeWidget {
  const AppBarEdit({
    Key? key,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  final void Function() onSave;
  final void Function() onCancel;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: kAppElevation,
      title: const Text('JobsIn'),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: onSave,
          icon: const FaIcon(FontAwesomeIcons.circleCheck),
          color: Colors.lime,
        ),
        IconButton(
          onPressed: onCancel,
          icon: const FaIcon(FontAwesomeIcons.xmark),
          color: Colors.deepOrange,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
