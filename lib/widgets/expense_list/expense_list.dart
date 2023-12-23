import 'package:flutter/material.dart';
import 'package:dicoding_submission_01/models/expense_data.dart';
import 'package:dicoding_submission_01/widgets/expense_list/expense_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.listExpense, required this.onRemove});

  final List<ExpenseData> listExpense;
  final void Function(ExpenseData expenseData) onRemove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listExpense.length,
      itemBuilder: (context, index) => Column(
        children: [
          Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error,
              margin: Theme.of(context).cardTheme.margin,
            ),
            key: ValueKey(listExpense[index]),
            onDismissed: (direction) {
              onRemove(listExpense[index]);
            },
            child: ExpenseItem(
              expenseItem: listExpense[index],
            ),
          ),
        ],
      ),
    );
  }
}
