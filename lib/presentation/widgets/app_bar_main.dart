import 'package:flutter/material.dart';

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
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: const AppLogo(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
