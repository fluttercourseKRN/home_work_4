import '../sort_element.dart';

enum VacanciesSortElement with SortElement {
  title('Title'),
  city('City');

  @override
  final String text;
  const VacanciesSortElement(this.text);
}
