import 'package:flutter/material.dart';
import 'renter.dart';

class LangScreen extends StatelessWidget {
  const LangScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> ls = [
      {'n': 'ಕನ್ನಡ', 'e': 'Kannada'}, {'n': 'English', 'e': 'English'}, {'n': 'हिन्दी', 'e': 'Hindi'}
    ];
    return Scaffold(
      appBar: AppBar(title: const Text("Select Language")),
      body: ListView.builder(
        itemCount: ls.length,
        itemBuilder: (c, i) => ListTile(
          title: Text(ls[i]['n']!, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(ls[i]['e']!),
          onTap: () => Navigator.push(c, MaterialPageRoute(builder: (c) => const RenterDash())),
        ),
      ),
    );
  }
}