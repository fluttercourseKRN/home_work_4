import 'package:jobsin/domain/entities/company.dart';

class CompanyApiResponse {
  final List<Company> companies = [];
  CompanyApiResponse.fromJson(Map<String, dynamic> data) {
    for (final elem in List.from(data["result"])) {
      companies.add(
        Company(
          id: elem['id'],
          name: elem['name'],
          description: elem['description'],
          industry: elem['industry'],
        ),
      );
    }
  }
}
