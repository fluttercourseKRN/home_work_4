import 'package:jobsin/domain/usecases/toggle_company_favorite_status.dart';
import 'package:jobsin/presentation/models/company_presentation.dart';
import 'package:jobsin/presentation/providers/abstract/favarite_togle_provider.dart';

class CompanyItemProvider extends FavoriteToggleProvider<CompanyPresentation,
    ToggleCompanyFavoriteStatus> {
  CompanyItemProvider({
    required super.context,
    required super.element,
    required super.toggleUseCase,
  });
}
