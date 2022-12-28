import 'package:flutter/material.dart';

class BottomNavigationScreen {
  final IconData icon;
  final String title;
  final String floatingButtonText;
  final Widget screen;
  final void Function(BuildContext context) onFloatingButtonTap;

  BottomNavigationScreen({
    required this.icon,
    required this.title,
    required this.floatingButtonText,
    required this.screen,
    required this.onFloatingButtonTap,
  });
}
