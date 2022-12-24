import 'package:flutter/material.dart';

import '../../domain/entities/vacancy.dart';
import '../providers/data_provider.dart';
import '../utils/validator.dart';
import '../widgets/app_bar_edit.dart';
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
  late final int? companyId;

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
      DataProvider.read(context).saveNewVacancy(
        title.text,
        city.text,
        description.text,
      );
      // Navigator.of(context).pop();
      // focusNode.
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
