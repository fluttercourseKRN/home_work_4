import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsin/domain/entities/vacancy.dart';
import 'package:jobsin/domain/model/enums/vacancies_sort_element.dart';
import 'package:jobsin/domain/usecases/get_vacancies_list.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetVacanciesList usecase;
  late MockVacanciesRepository vacanciesRepository;
  setUp(() {
    vacanciesRepository = MockVacanciesRepository();
    usecase = GetVacanciesList(vacanciesRepository);
  });

  const tFavoriteOnly = false;
  const tSortElement = VacanciesSortElement.none;
  final tVacancies = [
    Vacancy(
      id: 0,
      companyId: 0,
      title: 'title0',
      description: 'description0',
      city: 'city0',
      isOwner: false,
      isFavorite: false,
    ),
    Vacancy(
      id: 1,
      companyId: 1,
      title: 'title1',
      description: 'description1',
      city: 'city1',
      isOwner: false,
      isFavorite: false,
    ),
  ];

  test('Should get vacancies list from repository', () async {
    when(
      vacanciesRepository.getVacanciesList(
        favoritesOnly: tFavoriteOnly,
        sortElement: tSortElement,
      ),
    ).thenAnswer(
      (_) async => Right(tVacancies),
    );

    final result = await usecase(
      VacanciesParams(
        favoritesOnly: tFavoriteOnly,
        sortElement: tSortElement,
      ),
    );
    expect(result, Right(tVacancies));
  });
}
