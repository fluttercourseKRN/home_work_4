// import 'package:flutter/material.dart';
// import 'package:jobsin/domain/model/enums/companies_sort_element.dart';
// import 'package:jobsin/presentation/providers/companies_provider.dart';
// import 'package:jobsin/presentation/widgets/companies_list.dart';
//
// import '../../domain/entities/company.dart';
// import '../../domain/model/sort_element.dart';
// import '../providers/vacancies_provider.dart';
// import '../widgets/app_menu.dart';
// import '../widgets/app_spinkit.dart';
//
// class CompaniesScreen extends StatelessWidget {
//   const CompaniesScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AppMenu(
//           sortElements: CompaniesSortElement.values,
//           currentSortField: VacanciesProvider.watch(context).companiesSortField,
//           onSortFieldChange: (SortElement value) =>
//               VacanciesProvider.read(context).setCompaniesSortField(value),
//           isOn: VacanciesProvider.watch(context).companiesShowFavoriteOnly,
//           switchChange: (bool value) =>
//               VacanciesProvider.read(context).toggleCompaniesShowFavoriteOnly(),
//         ),
//         const Divider(),
//         Expanded(
//           child: FutureBuilder<List<Company>>(
//             future: CompaniesProvider.watch(context).companies,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 final companies = snapshot.data!;
//                 return CompaniesList(companies: companies);
//               }
//               return const AppSpinkit();
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
