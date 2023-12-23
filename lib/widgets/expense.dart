import 'package:dicoding_submission_01/widgets/charts/chart.dart';
import 'package:dicoding_submission_01/widgets/expense_add.dart';
import 'package:dicoding_submission_01/widgets/expense_list/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_submission_01/models/expense_data.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  void _addExpense(ExpenseData expenseData) {
    setState(() {
      registeredExpense.add(expenseData);
    });
  }

  void _removeExpense(ExpenseData expenseData) {
    final expenseIndex = registeredExpense.indexOf(expenseData);
    setState(() {
      registeredExpense.remove(expenseData);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense deleted"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              registeredExpense.insert(expenseIndex, expenseData);
            });
          },
        ),
      ),
    );
  }

  void openExpenseAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseAdd(onAddExpense: _addExpense),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Add some expenses!",
            style: TextStyle(
              color: Color.fromRGBO(130, 130, 130, 1),
            ),
          ),
        ],
      ),
    );

    if (registeredExpense.isNotEmpty) {
      mainContent = ExpenseList(
        listExpense: registeredExpense,
        onRemove: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expense Tracker",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            onPressed: openExpenseAdd,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Chart(expenseDataList: registeredExpense),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
