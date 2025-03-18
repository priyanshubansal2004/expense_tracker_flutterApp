import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<StatefulWidget> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Pizza",
        amount: 120,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Project",
        amount: 50,
        date: DateTime.now(),
        category: Category.work)
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context, builder: (ctx) => NewExpense(_addExpense));
  }

  void _addExpense(Expense expense) {
    
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
             });
            }),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No Expense? Ghar leke jayega Pesa?"),
    );
      if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(_removeExpense, _registeredExpenses);
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Title(color: Colors.black, child: const Text("ExpenseTracker")),
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}