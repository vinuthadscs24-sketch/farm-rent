import 'package:flutter/material.dart';
import 'lang.dart';

class PermScreen extends StatefulWidget {
  const PermScreen({super.key});
  @override
  State<PermScreen> createState() => _PermScreenState();
}

class _PermScreenState extends State<PermScreen> {
  int _step = 0;

  final List<Map<String, dynamic>> _perms = [
    {'title': 'Allow farmrent to access this device\'s location?', 'icon': Icons.location_on, 'isLoc': true},
    {'title': 'Allow farmrent to take pictures and record video?', 'icon': Icons.camera_alt, 'isLoc': false},
    {'title': 'Allow farmrent to send you notifications?', 'icon': Icons.notifications, 'isLoc': false},
  ];

  void _handlePermission() {
    if (_step < 2) {
      setState(() => _step++);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LangScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Container(
          width: 320, padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_perms[_step]['icon'], color: Colors.blueGrey, size: 35),
              const SizedBox(height: 15),
              Text(_perms[_step]['title'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 17)),
              const SizedBox(height: 20),
              if (_perms[_step]['isLoc']) ...[
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  _locType(Icons.grid_view, "Precise"), _locType(Icons.map_outlined, "Approximate")
                ]),
                const SizedBox(height: 20),
              ],
              _btn("While using the app"),
              _btn("Only this time"),
              _btn("Don't allow"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _locType(IconData i, String l) => Column(children: [Icon(i, size: 40, color: Colors.blue), Text(l, style: const TextStyle(fontSize: 11))]);
  Widget _btn(String t) => SizedBox(width: double.infinity, child: TextButton(onPressed: _handlePermission, child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold))));
}