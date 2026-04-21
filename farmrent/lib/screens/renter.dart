import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RenterDash extends StatefulWidget {
  const RenterDash({super.key});

  @override
  State<RenterDash> createState() => _RenterDashState();
}

class _RenterDashState extends State<RenterDash> {
  int _selectedIndex = 0;
  String userName = "Farmer Vinutha"; // Variable to allow editing

  // --- Logic to Edit Name ---
  void _editName() {
    TextEditingController _controller = TextEditingController(text: userName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Name"),
        content: TextField(controller: _controller, decoration: const InputDecoration(hintText: "Enter your name")),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              setState(() => userName = _controller.text);
              Navigator.pop(context);
            },
            child: const Text("Save", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Moved screens inside build so 'userName' updates in Profile
    final List<Widget> _screens = [
      const HomeScreen(),
      const MyBookingsScreen(),
      const PaymentScreen(),
      ProfilePage(userName: userName, onEdit: _editName),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 80, // Slightly taller for the search bar
        title: Container(
          height: 45,
          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search Equipment...",
              hintStyle: const TextStyle(fontSize: 14),
              prefixIcon: const Icon(Icons.search, color: Colors.black54),
              suffixIcon: IconButton(
                icon: const Icon(Icons.mic, color: Colors.green),
                onPressed: () => _showVoiceSearch(context),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black), // Filter Icon
            onPressed: () => _showFilters(context),
          ),
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none_outlined, color: Colors.black),
                Positioned(right: 0, top: 0, child: CircleAvatar(radius: 4, backgroundColor: Colors.orange[800]))
              ],
            ),
            onPressed: () => _showNotifications(context),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green[800],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'Payments'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Search Filters", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            const Text("Price Range (per day)"),
            RangeSlider(values: const RangeValues(200, 5000), min: 0, max: 10000, divisions: 10, labels: const RangeLabels("₹200", "₹5k"), onChanged: (v){}),
            const Text("Max Distance (km)"),
            Slider(value: 10, min: 0, max: 50, divisions: 5, label: "10km", onChanged: (v){}),
            ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 45)), child: const Text("Apply Filters", style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }

  void _showVoiceSearch(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.green[900],
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Container(
        height: 300,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white38, borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 30),
            const Text("Listening...", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300)),
            const Spacer(),
            const Icon(Icons.mic, color: Colors.white, size: 70),
            const Spacer(),
            const Text("Try: 'Find Harvesters near me'", style: TextStyle(color: Colors.white60)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(color: Color(0xFFF8F9FA), borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Text("System Alerts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            _notificationTab("Booking Confirmed", "Your Tractor booking for tomorrow is confirmed.", "Just now", Icons.check_circle, Colors.green),
            _notificationTab("Due Soon!", "Mini Harvester rental ends in 2 hours.", "10m ago", Icons.warning_amber_rounded, Colors.orange),
            _notificationTab("Payment Received", "₹1,800 received for Power Tiller.", "2h ago", Icons.account_balance_wallet, Colors.blue),
            _notificationTab("Refund Issued", "₹500 refunded for damage discrepancy.", "Yesterday", Icons.history, Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _notificationTab(String title, String body, String time, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[200]!)),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(body, style: const TextStyle(fontSize: 12)),
        trailing: Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ),
    );
  }
}

// --- HOME, BOOKINGS, PAYMENTS SCREENS REMAIN IDENTICAL ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWeatherCard(),
          const SizedBox(height: 25),
          const Text("Crop Advisory", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(children: [
            _advisoryCard("Grow: Ragi", "Climate is ideal.", Colors.green, Icons.check_circle),
            const SizedBox(width: 10),
            _advisoryCard("Avoid: Tomato", "High pest risk.", Colors.red, Icons.warning),
          ]),
          const SizedBox(height: 25),
          const Text("Kits Available Nearby", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          _kitCard("Rice Sowing Kit", "Tractor + Seeder", "₹1,200/day", "Ganesh Rentals", "1.2 km"),
        ],
      ),
    );
  }

  Widget _buildWeatherCard() => Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.orange[400], borderRadius: BorderRadius.circular(20)), child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("32°C", style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold)), Text("Sunny Day", style: TextStyle(color: Colors.white70))]), Icon(Icons.wb_sunny, color: Colors.white, size: 80)]));
  Widget _advisoryCard(String t, String d, Color c, IconData i) => Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: c.withOpacity(0.05), borderRadius: BorderRadius.circular(12), border: Border.all(color: c.withOpacity(0.1))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(i, color: c, size: 20), Text(t, style: TextStyle(fontWeight: FontWeight.bold, color: c)), Text(d, style: const TextStyle(fontSize: 11))])));
  Widget _kitCard(String n, String t, String p, String o, String d) => Card(margin: const EdgeInsets.only(top: 10), child: ListTile(leading: const Icon(Icons.agriculture, color: Colors.green), title: Text(n), subtitle: Text("$t\nBy $o • $d"), trailing: Text(p, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))));
}

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("🔹 1. Current Section (Active)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _activeCard("Mahindra Tractor", "Ramesh G.", "Apr 15 → Apr 18", "₹2,400", "9876543210"),
        const SizedBox(height: 25),
        const Text("🔹 2. Past Section (History)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _pastCard("Power Tiller", "Suresh P.", "Apr 10", "₹1,800", "UPI", true),
        _pastCard("Mini Harvester", "Venkatesh", "Apr 05", "₹4,200", "Cash", false),
      ],
    );
  }

  Widget _activeCard(String name, String owner, String date, String amt, String phone) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const Text("ACTIVE ✅", style: TextStyle(color: Colors.green, fontSize: 12))]),
        Text("Owner: $owner"),
        Text("📅 $date"),
        Text("Paid: $amt", style: const TextStyle(fontWeight: FontWeight.bold)),
        const Divider(),
        Row(
          children: [
            Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.report_gmailerrorred, color: Colors.white, size: 18), label: const Text("Report Issue", style: TextStyle(color: Colors.white, fontSize: 12)), style: ElevatedButton.styleFrom(backgroundColor: Colors.red[400]))),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () async => await launchUrl(Uri.parse("tel:$phone")),
              icon: const Icon(Icons.call, color: Colors.white, size: 18),
              label: const Text("Call", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        ),
      ]),
    ),
  );

  Widget _pastCard(String name, String owner, String date, String amt, String method, bool rated) => Card(
    color: Colors.grey[50],
    child: ListTile(
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("By $owner • $date • Completed\n$amt ($method)"),
      trailing: rated ? const Icon(Icons.star, color: Colors.orange, size: 18) : const Text("Rate Now ⭐", style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
    ),
  );
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(12)), child: const Row(children: [Icon(Icons.report_gmailerrorred, color: Colors.red), SizedBox(width: 10), Expanded(child: Text("Damage Charges: ₹1,200 (Reported by Owner Suresh)", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13)))] )),
        const SizedBox(height: 25),
        const Text("Payment History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        _paymentTile("Harvester (Shared)", "via Google Pay • April 10", "₹4,500"),
        _paymentTile("Plow (Single)", "via PhonePe • April 05", "₹600"),
      ]),
    );
  }

  Widget _paymentTile(String title, String subtitle, String amount) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey[200]!)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [const Icon(Icons.account_balance_wallet, color: Colors.green), const SizedBox(width: 15), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey))])]), Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))]));
}

// --- PROFILE SCREEN WITH EDIT NAME OPTION ---
class ProfilePage extends StatelessWidget {
  final String userName;
  final VoidCallback onEdit;
  const ProfilePage({super.key, required this.userName, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        Stack(children: [
          const CircleAvatar(radius: 55, backgroundColor: Colors.green, child: CircleAvatar(radius: 52, backgroundImage: NetworkImage('https://via.placeholder.com/150'))),
          Positioned(bottom: 0, right: 0, child: CircleAvatar(backgroundColor: Colors.white, radius: 18, child: IconButton(icon: const Icon(Icons.camera_alt, size: 16, color: Colors.green), onPressed: () {})))
        ]),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            IconButton(onPressed: onEdit, icon: const Icon(Icons.edit, size: 18, color: Colors.grey)),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.amber, size: 18),
            Text(" 4.8", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(" (12 reviews)", style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        const Text("Member since 2024", style: TextStyle(color: Colors.grey, fontSize: 14)),
        const Divider(height: 40),
        _profileTile(Icons.phone_android, "Change Mobile Number", "98765 43210"),
        _profileTile(Icons.location_on_outlined, "Manage Address", "Bengaluru South"),
        _profileTile(Icons.sync_alt, "Switch User Role", "Current: Renter"),
        _profileTile(Icons.help_center_outlined, "Help & FAQ", ""),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)), child: const Text("Log Out", style: TextStyle(color: Colors.red)))),
      ]),
    );
  }

  Widget _profileTile(IconData i, String t, String s) => ListTile(leading: Icon(i, color: Colors.green), title: Text(t, style: const TextStyle(fontSize: 15)), subtitle: s != "" ? Text(s, style: const TextStyle(fontSize: 12)) : null, trailing: const Icon(Icons.arrow_forward_ios, size: 14));
}