import 'package:expense_tracker/widgets/expenses_list/expene_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(this.removeExpense, this.expenses, {super.key});

  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: Theme.of(context).cardTheme.margin,
        ),
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            removeExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index])),
    );
  }
}
