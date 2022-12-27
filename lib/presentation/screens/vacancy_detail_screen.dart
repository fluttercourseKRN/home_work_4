import 'package:flutter/material.dart';

import '../../domain/entities/vacancy.dart';
import '../widgets/app_bar_main.dart';
import '../widgets/info_card.dart';
import '../widgets/label_value.dart';

class VacancyDetailScreen extends StatelessWidget {
  const VacancyDetailScreen({
    Key? key,
    required this.vacancy,
  }) : super(key: key);

  static const route = '/vacancy_detail_screen';

  final Vacancy vacancy;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMain(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InfoCard(
            items: [
              LabelValue(
                label: 'Title: ',
                text: vacancy.title,
              ),
              LabelValue(
                label: 'City: ',
                text: vacancy.city,
              ),
              LabelValue(
                label: 'Description: ',
                text: vacancy.description,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
