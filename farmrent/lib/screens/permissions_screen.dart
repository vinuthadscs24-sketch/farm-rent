import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'language_screen.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  int _currentStep = 0;

  final List<Map<String, dynamic>> _steps = [
    {
      "permission": Permission.location,
      "title": "Precision Location Services",
      "desc": "To facilitate accurate logistics and coordinate equipment delivery to your specific farm location, we require access to your device location.",
      "icon": Icons.gps_fixed,
    },
    {
      "permission": Permission.camera,
      "title": "Digital Documentation Access",
      "desc": "To maintain high safety standards, camera access is required for equipment inspections and verifying tool conditions.",
      "icon": Icons.photo_camera,
    },
  ];

  Future<void> _handlePermissionRequest(Permission perm) async {
    final status = await perm.request();

    // Logic: Transition only happens if they interact with the system popup
    if (status.isGranted || status.isLimited || status.isDenied) {
      if (_currentStep < _steps.length - 1) {
        setState(() => _currentStep++);
      } else {
        if (mounted) {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LanguageScreen())
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStep];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Icon(step['icon'], size: 80, color: Colors.green[800]),
              const SizedBox(height: 30),
              Text(step['title'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Text(step['desc'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.5)),
              const Spacer(),
              _permButton("Grant Authorization", Colors.green[800]!, Colors.white, step['permission']),
              _permButton("Allow Only This Time", Colors.green[100]!, Colors.black, step['permission']),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _permButton(String text, Color bg, Color tc, Permission p) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0), // Fixed the margin error here
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: tc,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () => _handlePermissionRequest(p),
          child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}