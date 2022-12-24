import 'package:flutter/material.dart';
import 'package:jobsin/di.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/company.dart';

class CompanyItemProvider extends ChangeNotifier {
  CompanyItemProvider({
    required this.company,
  });
  factory CompanyItemProvider.read(BuildContext context) =>
      context.read<CompanyItemProvider>();

  factory CompanyItemProvider.watch(BuildContext context) =>
      context.watch<CompanyItemProvider>();

  final Company company;

  void toggleIsFavorite() {
    company.isFavorite = !company.isFavorite;
    final repository = DI.instance.repository;
    if (company.isFavorite) {
      repository.saveCompanyToFavorite(company.id);
    } else {
      repository.deleteCompanyFromFavorite(company.id);
    }
    notifyListeners();
  }
}
