import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/companies_provider.dart';

import '../../core/utils/validator.dart';
import '../../domain/entities/company.dart';
import '../widgets/app_bar_edit.dart';
import '../widgets/app_text_form_field.dart';

class CompanyEditScreen extends StatefulWidget {
  const CompanyEditScreen({Key? key, this.initialCompany}) : super(key: key);

  static const route = '/company_edit_screen';
  final Company? initialCompany;
  @override
  State<CompanyEditScreen> createState() => _CompanyEditScreenState();
}

class _CompanyEditScreenState extends State<CompanyEditScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController name;
  late final TextEditingController industry;
  late final TextEditingController description;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    name = TextEditingController(
      text: widget.initialCompany?.name ?? '',
    );
    industry = TextEditingController(
      text: widget.initialCompany?.industry ?? '',
    );
    description = TextEditingController(
      text: widget.initialCompany?.description ?? '',
    );
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
                /// Company name
                AppTextFormField(
                  controller: name,
                  labelText: "Company name",
                  validator: Validator.basicValidator,
                ),
                const SizedBox(height: 16),

                /// Industry
                AppTextFormField(
                  controller: industry,
                  labelText: "Industry",
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
      CompaniesProvider.read(context).addNewCompany(
        name.text,
        description.text,
        industry.text,
      );
      Navigator.of(context).pop();
      // focusNode.
    } else {}
  }

  void _cancel() {
    Navigator.of(context).pop();
  }
}
