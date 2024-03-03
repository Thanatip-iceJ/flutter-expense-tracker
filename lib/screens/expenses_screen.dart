import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/components/add_expense_sheet.dart';
import 'package:flutter_expense_tracker/components/chart.dart';
import 'package:flutter_expense_tracker/components/expense_list.dart';
import 'package:flutter_expense_tracker/models/expense.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> registeredExpenses = [
    Expense(
        title: "Flutter course",
        amount: 399,
        category: Category.work,
        date: DateTime.now()),
    Expense(
        title: "Cinema",
        amount: 299,
        category: Category.leisure,
        date: DateTime.now()),
    Expense(
        title: "Gaming",
        amount: 499,
        category: Category.leisure,
        date: DateTime.now()),
  ];

  void openAddOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => AddExpenseSheet(addExpense));
  }

  void addExpense(
      String title, double amount, Category category, DateTime date) {
    setState(() {
      registeredExpenses.add(Expense(
          title: title, amount: amount, category: category, date: date));
    });
  }

  void removeExpense(Expense item) {
    final foundIndex = registeredExpenses.indexOf(item);
    setState(() {
      registeredExpenses.remove(item);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(
          "An Expense has been deleted.",
          style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              registeredExpenses.insert(foundIndex, item);
            });
          },
        )));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text(
        "No expenses found, try adding something.",
        style: GoogleFonts.roboto(fontSize: 16),
      ),
    );
    if (registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: registeredExpenses,
        delete: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: openAddOverlay,
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
        title: Text("Expense Tracker App",
            style: GoogleFonts.prompt(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Chart(expenses: registeredExpenses),
            Expanded(child: mainContent)
          ],
        ),
      ),
    );
  }
}
