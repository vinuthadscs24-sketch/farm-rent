import 'package:flutter/material.dart';
import 'role_selection_screen.dart'; // IMPORTANT: Connects to Role Selection

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OTP Verification")),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text("Enter 4-digit OTP"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => SizedBox(
                width: 50,
                child: TextField(
                  controller: _controllers[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  decoration: const InputDecoration(counterText: ""),
                  onChanged: (v) { if(v.isNotEmpty && index < 3) FocusScope.of(context).nextFocus(); },
                ),
              )),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RoleSelectionScreen()));
              },
              child: const Text("VERIFY OTP"),
            ),
          ],
        ),
      ),
    );
  }
}