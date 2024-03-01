import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/screens/expenses_screen.dart';

void main() {
  runApp(const App());
}

var kColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.deepPurple, brightness: Brightness.dark);

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: kColorScheme,
          useMaterial3: true,
          appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).colorScheme.primary)),
      home: const ExpensesScreen(),
    );
  }
}
