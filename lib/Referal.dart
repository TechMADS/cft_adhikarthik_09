import 'package:carbon_footprint_tracker_by_teamtech_mads/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class referal extends StatelessWidget {
  const referal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReferralPage(),
    );
  }
}

class ReferralPage extends StatelessWidget {
  ReferralPage({super.key});

  final String referralLink = "https://yourapp.com/referral?code=ABC123";

  void shareReferral() {
    Share.share("Join me on the Carbon Measurement App! Use my referral code and earn rewards: $referralLink");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context)=> HomeScreen()),);
        }, icon:Icon(Icons.arrow_back),color: Colors.white,),
      ),
      backgroundColor: Colors.orange,
      body: Column(
        children: [
          // Top Section with text and graphics
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "Earn 200 Coins!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Invite your friends and family to our Carbon Measurement App. Earn on their first emission tracking!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: shareReferral,
                    icon: const Icon(Icons.help_outline),
                    label: const Text("How to refer a friend"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Section with invite options
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Invite",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),

                    ),
                  ),
                  const SizedBox(height: 15),

                  // Social Media Invite Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _inviteButton("Whatsapp", FontAwesomeIcons.whatsapp, Colors.green),

                      _inviteButton("Facebook", Icons.facebook, Colors.blue),
                      _inviteButton("Instagram", Icons.camera_alt, Colors.purple),
                      _inviteButton("More", Icons.more_horiz,Colors.white),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Text(
                    "Suggested Contacts",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 10),

                  // Suggested Contacts List
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      _contactCard("d", "dhina..."),
                      _contactCard("a", "adhi..."),
                      _contactCard("m", "murali ..."),
                      _contactCard("s", "sakthi ..."),

                    ],
                  ),

                  const SizedBox(height: 20),

                  // Search Box
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Search by Number or Name",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Invite Button Widget
  Widget _inviteButton(String label, IconData icon, Color color) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withValues(alpha: 0),
          radius: 25,
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.white)),
      ],
    );
  }

  // Contact Card Widget
  Widget _contactCard(String initials, String name) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.orange,
          radius: 25,
          child: Text(
            initials,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5),
        Text(name, style: const TextStyle(fontSize: 14, color: Colors.white),),
        TextButton(
          onPressed: shareReferral,
          child: const Text("INVITE", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
