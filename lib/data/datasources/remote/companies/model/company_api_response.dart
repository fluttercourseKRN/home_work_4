import '../../../../models/company_model.dart';

class CompanyApiResponseConverter {
  static List<CompanyModel> convert(Map<String, dynamic> data) {
    final List<CompanyModel> companies = [];
    for (final elem in List.from(data["result"])) {
      try {
        final company = CompanyModel(
          id: elem['id'],
          name: elem['name'],
          description: elem['description'],
          industry: elem['industry'],
        );
        companies.add(company);
      } catch (e) {
        continue;
      }
    }
    return companies;
  }
}
