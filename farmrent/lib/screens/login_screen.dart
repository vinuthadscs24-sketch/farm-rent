import 'package:flutter/material.dart';
import 'renter_dashboard.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        children: [
          const SizedBox(height: 80),
          const Icon(Icons.agriculture, size: 100, color: Colors.green),
          const SizedBox(height: 10),
          const Center(
            child: Text("FarmRent",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.green)),
          ),
          const Center(child: Text("Formal Tool Sharing & Farmer Network")),
          const SizedBox(height: 60),
          const TextField(
            decoration: InputDecoration(
              labelText: "User ID or Mobile Number",
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            obscureText: _isObscured,
            decoration: InputDecoration(
              labelText: "Password",
              prefixIcon: const Icon(Icons.lock_outline),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => _isObscured = !_isObscured),
              ),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                // Navigates straight to the Dashboard
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const RenterDashboard()),
                      (route) => false,
                );
              },
              child: const Text(
                "SIGN IN",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ), // Added missing closing bracket for SizedBox
          const SizedBox(height: 20), // Reduced spacing slightly
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("New user? "),
              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen())),
                child: const Text("Register Here", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}