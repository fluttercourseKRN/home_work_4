import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppSpinkit extends StatelessWidget {
  const AppSpinkit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWave(color: Theme.of(context).colorScheme.primary),
    );
  }
}
