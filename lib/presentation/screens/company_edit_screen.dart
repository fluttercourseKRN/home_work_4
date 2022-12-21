import 'package:flutter/material.dart';
import 'package:jobsin/domain/model/company.dart';

class CompanyEditScreen extends StatefulWidget {
  const CompanyEditScreen({Key? key, this.initialCompany}) : super(key: key);

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
    return Form(
      child: Column(),
    );
  }
}
