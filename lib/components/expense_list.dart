import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/components/expenses_item.dart';
import 'package:flutter_expense_tracker/models/expense.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList({super.key, required this.expenses, required this.delete});

  final List<Expense> expenses;
  void Function(Expense item) delete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
              key: ValueKey(expenses[index]),
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.8),
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onDismissed: (direction) {
                delete(expenses[index]);
              },
              child: ExpenseItem(expenses[index]),
            ));
  }
}
