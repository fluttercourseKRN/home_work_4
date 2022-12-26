import '../sort_element.dart';

enum CompaniesSortElement with SortElement {
  none('none'),
  name('Name'),
  industry('Industry');

  @override
  List<CompaniesSortElement> get possibleValues {
    return CompaniesSortElement.values;
  }

  @override
  final String text;
  const CompaniesSortElement(this.text);
}
