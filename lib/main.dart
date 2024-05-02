import 'package:flutter/material.dart';
import 'package:pizza_ui/data/database.dart';
import 'package:pizza_ui/screens/bottom_nav.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MyDatabase myDatabase = MyDatabase();
  myDatabase.open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: const BottomNavScreen(),
    );
  }
}
