import 'package:flutter/material.dart';

import '../../domain/model/sort_element.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({
    Key? key,
    required this.currentSortField,
    required this.onSortFieldChange,
    required this.isOn,
    required this.switchChange,
    required this.sortElements,
  }) : super(key: key);

  final List<SortElement> sortElements;
  final SortElement currentSortField;
  final void Function(SortElement value) onSortFieldChange;

  final bool isOn;
  final void Function(bool value) switchChange;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 150,
        child: PopupMenuButton<SortElement>(
          position: PopupMenuPosition.under,
          child: Center(
            child: Row(
              children: [
                const Text(
                  "Sort by: ",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  currentSortField.text,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
            ),
          ),
          itemBuilder: (context) {
            return [
              for (final value in sortElements)
                PopupMenuItem<SortElement>(
                  child: Text(value.text),
                  onTap: () {
                    onSortFieldChange(value);
                    // print(value);
                  },
                )
            ];
          },
        ),
      ),
      trailing: Switch(
        activeColor: Theme.of(context).colorScheme.primary,
        onChanged: switchChange,
        value: isOn,
      ),
    );
  }
}
