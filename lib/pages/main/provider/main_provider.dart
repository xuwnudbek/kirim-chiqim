// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  final searchController = TextEditingController();

  DateTimeRange dateTimeRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 365)),
    end: DateTime.now(),
  );

  //Constructor
  MainProvider();

  Future<void> selectDateRange(BuildContext context) async {
    var dateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (dateRange != null) {
      dateTimeRange = dateRange;
      notifyListeners();
    }
  }
}

enum ProcessType { CREATE, UPDATE }
