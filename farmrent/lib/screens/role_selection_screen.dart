import 'package:flutter/material.dart';
import 'renter.dart'; // IMPORTANT: Connects to Dashboard

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Select Your Role", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800], minimumSize: const Size(250, 60)),
              onPressed: () {
                // Remove all previous screens and go to Home
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const RenterDashboard()),
                      (route) => false,
                );
              },
              child: const Text("I AM A FARMER (RENTER)", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}