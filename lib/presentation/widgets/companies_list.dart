import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jobsin/domain/model/company.dart';

import '../providers/data_provider.dart';

class CompaniesList extends StatelessWidget {
  const CompaniesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Company>>(
      future: DataProvider.watch(context).companies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final companies = snapshot.data!;
          return ListView.builder(
            itemCount: companies.length,
            itemBuilder: (context, index) {
              final company = companies[index];
              return ListTile(title: Text(company.name), onTap: () {});
            },
          );
        }
        return Center(
          child: SpinKitWave(color: Theme.of(context).colorScheme.primary),
        );
      },
    );
  }
}
