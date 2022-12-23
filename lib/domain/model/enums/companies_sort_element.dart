import '../sort_element.dart';

enum CompaniesSortElement with SortElement {
  name('Name'),
  industry('Industry');

  @override
  final String text;
  const CompaniesSortElement(this.text);
}
