import '../sort_element.dart';

enum VacanciesSortElement with SortElement {
  none('none'),
  title('Title'),
  city('City');

  @override
  final String text;
  const VacanciesSortElement(this.text);
}
