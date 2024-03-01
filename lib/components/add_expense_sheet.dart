import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/expense.dart';

class AddExpenseSheet extends StatefulWidget {
  AddExpenseSheet(this.addExpense, {super.key});

  void Function(String title, double amout, Category category, DateTime date)
      addExpense;

  @override
  State<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.leisure;

  void openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void submitHandle() {
    final convertedAmount = double.tryParse(amountController.text);
    final isErrorAmount =
        convertedAmount == null || convertedAmount <= 0 ? true : false;
    if (titleController.text.trim().isEmpty ||
        isErrorAmount ||
        selectedDate == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Invalid input"),
                content: const Text(
                    "Please make sure all inputs are entered before creating a new expense."),
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Okay"))
                ],
              ));
      return;
    }
    widget.addExpense(
        titleController.text, convertedAmount, selectedCategory, selectedDate!);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            maxLength: 30,
            decoration: const InputDecoration(labelText: "Expense Title"),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Amount", prefixText: "฿ "),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(selectedDate == null
                      ? 'No date selected.'
                      : formatter.format(selectedDate!)),
                  const SizedBox(
                    width: 8,
                  ),
                  IconButton(
                      onPressed: openDatePicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              DropdownButton(
                  value: selectedCategory,
                  items: Category.values
                      .map(
                        (e) => DropdownMenuItem(
                            value: e, child: Text(e.name.toUpperCase())),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val == null) {
                      return;
                    }
                    setState(() {
                      selectedCategory = val;
                    });
                  }),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(
                        side: BorderSide(color: Colors.deepPurple))),
                onPressed: submitHandle,
                child: const Text('Save Expense'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(
                        side: BorderSide(color: Colors.deepPurple))),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              )
            ],
          )
        ],
      ),
    );
  }
}
