import 'package:dicoding_submission_01/assets/themes/app_themes.dart';
import 'package:dicoding_submission_01/widgets/expense.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const Expense(),
    ),
  );
}
