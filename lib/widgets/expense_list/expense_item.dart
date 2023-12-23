import 'package:flutter/material.dart';
import 'package:dicoding_submission_01/models/expense_data.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expenseItem});

  final ExpenseData expenseItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expenseItem.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  children: [
                    Text("IDR ${expenseItem.formatCurrency}"),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          categoryIcons[expenseItem.category],
                          size: 20,
                        ),
                        Text(expenseItem.formatDate)
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
