import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
var formatter = DateFormat.yMd();

final List<ExpenseData> registeredExpense = [];

enum Category { food, entertainment, work, shelter }

final categoryIcons = {
  Category.food: Icons.fastfood,
  Category.entertainment: Icons.interests,
  Category.work: Icons.work,
  Category.shelter: Icons.night_shelter_outlined,
};

class ExpenseData {
  ExpenseData({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatDate {
    return formatter.format(date);
  }

  String get formatCurrency {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 2);
    return formatCurrency.format(amount);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenseDataList});

  ExpenseBucket.forCategory(List<ExpenseData> allExpenseDataList, this.category)
      : expenseDataList = allExpenseDataList
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<ExpenseData> expenseDataList;

  double get totalExpense {
    double sum = 0;

    for (final expense in expenseDataList) {
      sum += expense.amount;
    }

    return sum;
  }
}
