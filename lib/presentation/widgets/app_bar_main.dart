import 'package:flutter/material.dart';
import 'package:jobsin/presentation/model/constants.dart';

import 'app_logo.dart';

class AppBarMain extends StatelessWidget with PreferredSizeWidget {
  const AppBarMain({
    Key? key,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);
  final bool automaticallyImplyLeading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: kAppElevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: const AppLogo(),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
