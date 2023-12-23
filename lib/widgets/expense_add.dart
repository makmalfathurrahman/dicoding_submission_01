import 'package:dicoding_submission_01/assets/themes/app_themes.dart';
import 'package:dicoding_submission_01/models/expense_data.dart';
import 'package:flutter/material.dart';

class ExpenseAdd extends StatefulWidget {
  const ExpenseAdd({super.key, required this.onAddExpense});

  final void Function(ExpenseData expenseData) onAddExpense;

  @override
  State<ExpenseAdd> createState() => _ExpenseAddState();
}

class _ExpenseAddState extends State<ExpenseAdd> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var _selectedDate;
  var _selectedCategory;

  void showDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(2000);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text("Please fill in all forms correctly"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Close"),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      ExpenseData(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Expense Tracker",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      label: Text("Title"),
                    ),
                    maxLength: 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                            label: Text("Amount"),
                            prefixText: "IDR ",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? "Select date"
                                  : formatter.format(_selectedDate),
                            ),
                            IconButton(
                              onPressed: showDate,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: DropdownButton(
                      items: Category.values
                          .map(
                            (data) => DropdownMenuItem(
                              value: data,
                              child: Text(
                                data.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      hint: const Text("Select Category"),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      value: _selectedCategory,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _submitExpense,
                        child: const Text("Save"),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
