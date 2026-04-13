import 'package:flutter/material.dart';

class RenterDashboard extends StatefulWidget {
  const RenterDashboard({super.key});

  @override
  State<RenterDashboard> createState() => _RenterDashboardState();
}

class _RenterDashboardState extends State<RenterDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MyBookingsScreen(),
    const PaymentScreen(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome, Farmer Vinutha", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            const Text("Happy Farming! 🌱", style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.mic, color: Colors.green), onPressed: () {}),
          IconButton(
            icon: const Stack(
              children: [
                Icon(Icons.notifications_none_outlined, color: Colors.black),
                Positioned(right: 0, top: 0, child: CircleAvatar(radius: 4, backgroundColor: Colors.red))
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Payments'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.orange[300]!, Colors.orange[600]!]),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [Icon(Icons.location_on, color: Colors.white, size: 16), Text(" Bengaluru, KA", style: TextStyle(color: Colors.white))]),
                    SizedBox(height: 5),
                    Text("32°C", style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                    Text("Sunny Day - ☀️", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
                Icon(Icons.wb_sunny_rounded, size: 70, color: Colors.white70),
              ],
            ),
          ),
          const SizedBox(height: 25),
          const Text("Crop Advisory", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              _adviceCard("Grow: Ragi/Millets", "Climate is ideal for dry crops.", Colors.green[50]!, Colors.green[800]!, Icons.check_circle),
              const SizedBox(width: 12),
              _adviceCard("Avoid: Tomato", "High risk of pest due to heat.", Colors.red[50]!, Colors.red[800]!, Icons.warning),
            ],
          ),
          const SizedBox(height: 25),
          const Text("Frequent Equipment Kits", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _kitItem("Rice Sowing Kit", "Tractor + Transplanter + Fertilizer", "₹1,200/day"),
          _kitItem("Harvesting Bundle", "Combine Harvester + Trolley", "₹2,500/day"),
        ],
      ),
    );
  }

  Widget _adviceCard(String title, String desc, Color bg, Color text, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: text.withOpacity(0.2))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: text, size: 20),
            const SizedBox(height: 5),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: text)),
            Text(desc, style: TextStyle(fontSize: 11, color: text.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }

  Widget _kitItem(String name, String tools, String price) {
    return Card(
      elevation: 0,
      // FIXED: Changed 'border' to 'side'
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.green[50], child: const Icon(Icons.agriculture, color: Colors.green)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(tools),
        trailing: Text(price, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Current Rentals", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _bookingCard("Mahindra Jivo Tractor", "Owner: Ramesh G.", "4 Days Left", "Single User", true),
        const SizedBox(height: 25),
        const Text("Past Rentals", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _bookingCard("Power Tiller", "Owner: Suresh P.", "Completed", "Shared Rental", false),
        _bookingCard("Seed Drill", "Owner: K. Kumar", "Returned", "Single User", false),
      ],
    );
  }

  Widget _bookingCard(String name, String lender, String status, String type, bool isActive) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(lender, style: const TextStyle(color: Colors.grey)),
                ]),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: isActive ? Colors.orange[50] : Colors.grey[100], borderRadius: BorderRadius.circular(20)),
                  child: Text(status, style: TextStyle(color: isActive ? Colors.orange[900] : Colors.grey[700], fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Type: $type", style: const TextStyle(fontSize: 13, color: Colors.blueGrey)),
                if (!isActive) TextButton(onPressed: () {}, child: const Text("Rate Now ⭐"))
                else ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(horizontal: 12)), child: const Text("Call Owner", style: TextStyle(color: Colors.white))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(12)),
          child: const Row(
            children: [
              Icon(Icons.report_problem, color: Colors.red),
              SizedBox(width: 10),
              Text("Pending: ₹800 (Due tomorrow)", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const Text("Payment History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _paymentTile("Harvester", "₹4,500", "Google Pay", "April 10", "Shared"),
        _paymentTile("Plow", "₹600", "PhonePe", "April 05", "Single"),
      ],
    );
  }

  Widget _paymentTile(String item, String price, String app, String date, String mode) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.account_balance_wallet, color: Colors.green),
        title: Text("$item ($mode)"),
        subtitle: Text("via $app • $date"),
        trailing: Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text("Vinutha S."),
          accountEmail: Text("+91 9876543210"),
          currentAccountPicture: CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person, size: 40, color: Colors.green)),
          decoration: BoxDecoration(color: Colors.green),
        ),
        _profileItem(Icons.edit, "Edit Profile"),
        _profileItem(Icons.swap_horizontal_circle, "Switch to Owner Mode", color: Colors.blue),
        _profileItem(Icons.security, "2-Factor Authentication"),
        _profileItem(Icons.privacy_tip, "Privacy Center"),
        _profileItem(Icons.help, "Help Center"),
        const Divider(),
        ListTile(
          title: const Text("Legal & Terms (3.1 - 3.5)", style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text("Refunds, Damages, & Reviews"),
          onTap: () => _showLegal(context),
          trailing: const Icon(Icons.info_outline),
        ),
        _profileItem(Icons.logout, "Logout", color: Colors.red),
      ],
    );
  }

  Widget _profileItem(IconData icon, String title, {Color color = Colors.black}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      trailing: const Icon(Icons.chevron_right, size: 18),
      onTap: () {},
    );
  }

  void _showLegal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Booking & Payment Rules", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Divider(),
              _legalText("3.1 Booking", "Provide accurate details. For agricultural use only."),
              _legalText("3.2 Payment", "All payments via app. No offline cash transactions."),
              _legalText("3.3 Damage", "Renter is responsible for tool maintenance during use."),
              _legalText("3.4 Refunds", "Cancellation within 24hrs for full refund."),
              _legalText("3.5 Reviews", "Fair ratings only. Abusive content will lead to bans."),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _legalText(String title, String desc) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Text("$title: $desc"));
  }
}