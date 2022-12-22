import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobsin/presentation/screens/company_edit_screen.dart';
import 'package:jobsin/presentation/screens/vacancy_edit_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            automaticallyImplyLeading: false,
            title: Text('JobsIn'),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.building,
              size: 32,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              'Add Company',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            onTap: () =>
                Navigator.of(context).pushNamed(CompanyEditScreen.route),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.fileSignature,
              size: 32,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              'Add Vacancy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            onTap: () =>
                Navigator.of(context).pushNamed(VacancyEditScreen.route),
          ),
        ],
      ),
    );
  }
}
