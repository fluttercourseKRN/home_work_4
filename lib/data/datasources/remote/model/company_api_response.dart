import '../../../models/company_model.dart';

class CompanyApiResponse {
  final List<CompanyModel> companies = [];
  CompanyApiResponse.fromJson(Map<String, dynamic> data) {
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
  }
}
