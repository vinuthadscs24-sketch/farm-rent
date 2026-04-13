import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String? _selected;

  final List<Map<String, String>> _languages = [
    {"eng": "English", "native": "English"},
    {"eng": "Hindi", "native": "हिन्दी"},
    {"eng": "Kannada", "native": "ಕನ್ನಡ"},
    {"eng": "Telugu", "native": "తెలుగు"},
    {"eng": "Tamil", "native": "தமிழ்"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Preferences"),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Manual Back Button
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text("Please select your preferred communication language",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  final lang = _languages[index];
                  return RadioListTile<String>(
                    title: Text(lang['native']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(lang['eng']!),
                    value: lang['eng']!,
                    groupValue: _selected,
                    activeColor: Colors.green[800],
                    onChanged: (value) => setState(() => _selected = value),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selected != null ? Colors.green[800] : Colors.grey[400],
                  ),
                  // Button is only active if _selected is not null
                  onPressed: _selected == null ? null : () {
                    // Final logic to dashboard
                  },
                  child: const Text("CONFIRM SELECTION", style: TextStyle(color: Colors.white))
              ),
            ),
          ],
        ),
      ),
    );
  }
}