import '../../domain/entities/company.dart';
import 'favorite_toggle.dart';

class CompanyPresentation extends Company implements FavoriteToggled {
  CompanyPresentation({
    required super.id,
    required super.name,
    required super.description,
    required super.industry,
    required super.isFavorite,
    required super.isOwner,
  });
  CompanyPresentation.fromCompany(Company company)
      : this(
          id: company.id,
          name: company.name,
          description: company.description,
          industry: company.industry,
          isFavorite: company.isFavorite,
          isOwner: company.isOwner,
        );
}
