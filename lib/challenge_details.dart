import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChallengeDetailPage extends StatelessWidget {
  final Map<String, dynamic> challenge;

  ChallengeDetailPage(this.challenge);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(challenge["title"])),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: challenge["color"],
            child: Text(
              challenge["title"],
              style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: (challenge["tasks"] as List<String>).map((task) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(task, style: TextStyle(fontSize: 16)),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
