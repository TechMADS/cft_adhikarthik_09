
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/homepage.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/challenge_details.dart';

class Challenge extends StatelessWidget {
  // Challenge({super.key});

  final List<Map<String, dynamic>> challenges = [
    {"title": "Daily Challenge", "xp": "300 XP", "color": Colors.blue, "icon": Icons.calendar_today, "tasks": [
      "🚴‍♂️ Car-Free Day - Use public transport or cycle",
      "💡 Energy Saver - Reduce electricity usage",
      "🥦 Plant-Based Meal - Eat vegetarian all day",
    ]},
    {"title": "Weekly Challenge", "xp": "500 XP", "color": Colors.green, "icon": Icons.view_week, "tasks": [
      "🚗 Reduce Car Use - Drive 30% less this week",
      "🔋 Charge Smart - Use energy-efficient appliances",
    ]},
    {"title": "Monthly Challenge", "xp": "1000 XP", "color": Colors.orange, "icon": Icons.calendar_month, "tasks": [
      "🌞 Solar Power Hour - 1 hour/day with no electricity",
      "🚿 Short Showers - Under 5 min showers for a month",
    ]},
    {"title": "Yearly Challenge", "xp": "2000 XP", "color": Colors.purple, "icon": Icons.event, "tasks": [
      "🌍 Carbon Neutral - Offset your carbon footprint",
      "🛍️ Sustainable Living - Buy second-hand or swap items",
    ]},
  ];

  final List<Map<String, String>> friends = [
    {"name": "Alice", "challenge": "Car-Free Day", "image": "https://static.vecteezy.com/system/resources/previews/024/183/502/original/male-avatar-portrait-of-a-young-man-with-a-beard-illustration-of-male-character-in-modern-color-style-vector.jpg"},
    {"name": "Bob", "challenge": "Short Showers", "image": "https://th.bing.com/th/id/OIP.trKxa-rj4kyOA6X6BLQ4rQHaHa?w=740&h=740&rs=1&pid=ImgDetMain"},
    {"name": "Charlie", "challenge": "Sustainable Living", "image": "https://img.freepik.com/premium-vector/slim-spiration-central-vector-illustration-cartoon_969863-2375.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("\t \t \t \t Challenges"),titleTextStyle: TextStyle(color: Colors.white,fontSize: 28),
        leading: IconButton(
            color:Colors.white,
            onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context)=> HomeScreen()),
              );
            }, icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.black,),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: challenges.length,
                  itemBuilder: (context, index) {
                    final challenge = challenges[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChallengeDetailPage(challenge),
                          ),
                        );
                      },
                      child: Container(

                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: challenge["color"],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(challenge["icon"], size: 40, color: Colors.white),
                            SizedBox(height: 8),
                            Text(
                              challenge["title"],
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4),
                            Text(
                              challenge["xp"],
                              style: TextStyle(fontSize: 14, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Friends Participating", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    final friend = friends[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(backgroundImage: NetworkImage(friend["image"]!)),
                        title: Text(friend["name"]!),
                        subtitle: Text("Currently doing: ${friend["challenge"]}"),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
      ),
    );
  }
}
