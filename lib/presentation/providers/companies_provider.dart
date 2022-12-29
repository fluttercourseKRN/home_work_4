import 'package:flutter/material.dart';
import 'package:jobsin/domain/usecases/add_company.dart';
import 'package:jobsin/domain/usecases/delete_company.dart';
import 'package:jobsin/domain/usecases/edit_company.dart';
import 'package:jobsin/domain/usecases/get_companies_list.dart';
import 'package:jobsin/domain/usecases/get_my_companies.dart';
import 'package:jobsin/presentation/providers/menu_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/company.dart';
import '../../domain/model/enums/companies_sort_element.dart';

class CompaniesProvider extends ChangeNotifier {
  CompaniesProvider({
    required this.context,
    required this.useCaseGetCompaniesList,
    required this.useCaseDeleteCompany,
    required this.useCaseAddCompany,
    required this.useCaseEditCompany,
    required this.useCaseGetMyCompanies,
  }) {
    _fetchCompanies();
  }

  factory CompaniesProvider.read(BuildContext context) =>
      context.read<CompaniesProvider>();

  factory CompaniesProvider.watch(BuildContext context) =>
      context.watch<CompaniesProvider>();
  //////////////////////////////////////////////////////////////////////////////

  final BuildContext context;
  //UseCases
  final GetCompaniesList useCaseGetCompaniesList;
  final GetMyCompanies useCaseGetMyCompanies;
  final DeleteCompany useCaseDeleteCompany;
  final AddCompany useCaseAddCompany;
  final EditCompany useCaseEditCompany;

  List<Company>? companies;

  void menuUpdate(MenuProvider<CompaniesSortElement> menuProvider) {
    _fetchCompanies(
      itemsShowFavoriteOnly: menuProvider.itemsShowFavoriteOnly,
      itemSortField: menuProvider.itemSortField,
    );
  }

  Future<void> _fetchCompanies({
    bool itemsShowFavoriteOnly = false,
    CompaniesSortElement itemSortField = CompaniesSortElement.none,
    bool isShowLoading = true,
  }) async {
    if (isShowLoading) {
      companies = null;
      super.notifyListeners();
    }
    final vacanciesListOrFailure = await useCaseGetCompaniesList(
      CompaniesParams(
        favoritesOnly: itemsShowFavoriteOnly,
        sortElement: itemSortField,
      ),
    );
    vacanciesListOrFailure.fold(
      (l) => companies = [],
      (r) => companies = [...r],
    );

    notifyListeners();
  }

  Future<List<Company>> getMyCompanies() async {
    final companiesOrFailure = await useCaseGetMyCompanies(null);

    return companiesOrFailure.fold(
      (l) {
        return [];
      },
      (r) {
        return r;
      },
    );
  }

  Future<void> editCompanySubmit({
    required int id,
    required String name,
    required String description,
    required String industry,
  }) async {
    final res = await useCaseEditCompany(
      EditCompanyParam(
        company: Company(
          id: id,
          name: name,
          description: description,
          industry: industry,
          isFavorite: false,
          isOwner: true,
        ),
      ),
    );
    _fetchCompanies();
  }

  Future<void> addNewCompany({
    required String name,
    required String description,
    required String industry,
  }) async {
    final res = await useCaseAddCompany(
      AddCompanyParam(
        company: Company(
          id: 0,
          name: name,
          description: description,
          industry: industry,
          isFavorite: false,
          isOwner: true,
        ),
      ),
    );
    _fetchCompanies();
  }

  Future<void> deleteCompany(int companyId) async {
    final res = await useCaseDeleteCompany(
      DeleteCompanyParam(companyId: companyId),
    );
    _fetchCompanies();
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: SizedBox(height: 50, child: Text(msg))));
  }
}
