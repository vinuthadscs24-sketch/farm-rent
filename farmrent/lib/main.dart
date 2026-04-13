import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  // Ensure Flutter is initialized before anything else
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FarmRentApp());
}

class FarmRentApp extends StatelessWidget {
  const FarmRentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FarmRent',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}