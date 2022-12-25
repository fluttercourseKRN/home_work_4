import '../../../../models/company_model.dart';

class CompanyApiResponseConverter {
  static List<CompanyModel> convert(Map<String, dynamic> data) {
    final List<CompanyModel> companies = [];
    for (final elem in List.from(data["result"])) {
      companies.add(
        CompanyModel(
          id: elem['id'],
          name: elem['name'],
          description: elem['description'],
          industry: elem['industry'],
        ),
      );
    }
    return companies;
  }
}
