import 'package:flutter/material.dart';
import 'otp.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscured1 = true;
  bool _isObscured2 = true;
  bool _agreed = false;

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  void _trySubmit() {
    if (_formKey.currentState!.validate() && _agreed) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const OTPScreen()));
    } else if (!_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must agree to the Terms & Conditions")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Create Farmer Account", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 60, color: Colors.white)
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 18,
                      child: IconButton(
                          icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                          onPressed: () {} // Logic for camera picker goes here
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TextFormField(
                decoration: const InputDecoration(labelText: "Full Name", border: OutlineInputBorder()),
                validator: (v) => (v == null || v.isEmpty) ? "Please enter your name" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    prefixText: "+91 ",
                    labelText: "Mobile Number",
                    border: OutlineInputBorder()
                ),
                validator: (v) => (v == null || v.length != 10) ? "Enter 10 digit mobile number" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _passController,
                obscureText: _isObscured1,
                decoration: InputDecoration(
                  labelText: "Create Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      icon: Icon(_isObscured1 ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _isObscured1 = !_isObscured1)
                  ),
                ),
                validator: (v) => (v == null || v.length < 6) ? "Password too short" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _confirmPassController,
                obscureText: _isObscured2,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      icon: Icon(_isObscured2 ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _isObscured2 = !_isObscured2)
                  ),
                ),
                validator: (v) => v != _passController.text ? "Passwords do not match" : null,
              ),
              const SizedBox(height: 15),
              CheckboxListTile(
                value: _agreed,
                onChanged: (v) => setState(() => _agreed = v!),
                title: const Text("I agree to the Terms (Fair usage & Tool safety)", style: TextStyle(fontSize: 12)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.green[800]
                ),
                onPressed: _trySubmit,
                child: const Text("GET OTP", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}