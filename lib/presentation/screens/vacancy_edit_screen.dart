import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:jobsin/domain/entities/company.dart';

import '../../core/utils/validator.dart';
import '../../domain/entities/vacancy.dart';
import '../providers/vacancies_provider.dart';
import '../widgets/app_bar_edit.dart';
import '../widgets/app_spinkit.dart';
import '../widgets/app_text_form_field.dart';

class VacancyEditScreen extends StatefulWidget {
  const VacancyEditScreen({Key? key, this.initialVacancy}) : super(key: key);

  static const route = '/vacancy_edit_screen';
  final Vacancy? initialVacancy;

  @override
  State<VacancyEditScreen> createState() => _VacancyEditScreenState();
}

class _VacancyEditScreenState extends State<VacancyEditScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController title;
  late final TextEditingController city;
  late final TextEditingController description;
  int? companyId;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    title = TextEditingController(
      text: widget.initialVacancy?.title ?? '',
    );
    city = TextEditingController(
      text: widget.initialVacancy?.city ?? '',
    );
    description = TextEditingController(
      text: widget.initialVacancy?.description ?? '',
    );
    companyId = widget.initialVacancy?.companyId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarEdit(onSave: _save, onCancel: _cancel),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              children: [
                /// Title
                AppTextFormField(
                  controller: title,
                  labelText: "Title",
                  validator: Validator.basicValidator,
                ),
                const SizedBox(height: 16),

                /// City
                AppTextFormField(
                  controller: city,
                  labelText: "City",
                  validator: Validator.basicValidator,
                ),
                const SizedBox(height: 16),

                /// Description
                AppTextFormField(
                  maxLine: 5,
                  minLine: 5,
                  controller: description,
                  labelText: "Description",
                  textInputAction: TextInputAction.newline,
                ),
                const SizedBox(height: 16),
                FutureBuilder<List<Company>>(
                  future: VacanciesProvider.read(context).getMyCompanies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final values = snapshot.data!;
                      final initial = values.firstWhereOrNull(
                            (element) => element.id == companyId,
                          ) ??
                          values.first;
                      companyId = initial.id;
                      return DropdownSearch<Company>(
                        itemAsString: (item) => item.name,
                        selectedItem: initial,
                        popupProps: const PopupProps.menu(),
                        dropdownButtonProps: const DropdownButtonProps(),
                        items: values,
                        onChanged: (value) {},
                      );
                    } else {
                      return const AppSpinkit();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _save() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      if (widget.initialVacancy == null) {
        VacanciesProvider.read(context).addNewVacancy(
          companyId: companyId!,
          title: title.text,
          city: city.text,
          description: description.text,
        );
      } else {
        VacanciesProvider.read(context).editVacancySubmit(
          id: widget.initialVacancy!.id,
          companyId: companyId!,
          title: title.text,
          city: city.text,
          description: description.text,
        );
      }
      Navigator.of(context).pop();
      print('Valid');
    } else {
      print('Not Valid');
    }
    // Navigator.of(context).pop();
  }

  void _cancel() {
    Navigator.of(context).pop();
  }
}
