import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/screens/expenses_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const App());
}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurple,
);

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: kColorScheme,
        cardTheme:
            const CardTheme().copyWith(color: kColorScheme.inverseSurface),
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.primary,
            foregroundColor: Colors.white70),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge:
                  GoogleFonts.roboto(fontSize: 24, color: Colors.white70),
              titleMedium: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
              bodyMedium: GoogleFonts.roboto(color: Colors.white70),
            ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            foregroundColor: Colors.black87),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge:
                  GoogleFonts.roboto(fontSize: 24, color: Colors.black87),
              titleMedium: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
              bodyMedium: GoogleFonts.roboto(color: Colors.black87),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.inversePrimary,
                foregroundColor: kColorScheme.inverseSurface)),
        cardTheme: const CardTheme().copyWith(
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      home: const ExpensesScreen(),
    );
  }
}
