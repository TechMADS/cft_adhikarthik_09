import 'package:carbon_footprint_tracker_by_teamtech_mads/Referal.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/challenge.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/homepage.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/reward_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class profilepage extends StatefulWidget {
  const profilepage({super.key});

  @override
  _ProfilePageState createState()=> _ProfilePageState();


}

class _ProfilePageState extends State<profilepage> {
  // BuildContext? get context => null;
  String?username;
  String?email;

  @override
  void initState() {
    super.initState();
    _getUserData();

  }

  Future<void> _getUserData() async{
    User? user =FirebaseAuth.instance.currentUser;
    if(user != null){
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
      setState(() {
        username = userDoc['username']??"User";
        email = userDoc['email']??'No email';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen()),);
        }, icon:Icon(Icons.arrow_back)),
        title: Text("\t \t \t \t \t User Profile",style: TextStyle(color: Colors.black,fontSize: 28),),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              CircleAvatar(
                radius: screenWidth * 0.15,
                backgroundImage: AssetImage("assets/profile.jpg"),
              ),
              SizedBox(height: 10),
              // User Name
              Text(
                "$username",
                style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold,color: Colors.white
                ),
              ),
              Text("🌍 Eco-Warrior | Sustainable Living Enthusiast",style:TextStyle(color: Colors.white),),
              SizedBox(height: 10),
              Divider(),
              // Carbon Stats
              profileStat("🌱 Carbon Footprint", "2.1 tons CO₂/year", screenWidth),
              profileStat("♻️ Trees Planted", "10", screenWidth),
              profileStat("🚴‍♂️ Sustainable Actions", "Cycling, Solar Panels", screenWidth),
              SizedBox(height: 20),
              // Responsive "Edit Profile" Button
              SizedBox(
                width: screenWidth * 0.7,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {},
                  child: Text("Edit Profile", style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              // Additional Sections (Challenges, Rewards, Referral)
              additionalSection(context, Icons.emoji_events, "Challenges", "Complete tasks & earn points", screenWidth,1),
              additionalSection(context, Icons.card_giftcard, "Rewards", "Redeem points for eco-friendly rewards", screenWidth,2),
              additionalSection(context, Icons.group, "Referral", "Invite friends & get benefits", screenWidth,3),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileStat(String label, String value, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.w500,color: Colors.white)),
          Text(value, style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.orange)),
        ],
      ),
    );
  }

  Widget additionalSection(BuildContext context, IconData icon, String title, String description, double screenWidth,int i) {
    return Card(
      color:Colors.orange,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.black, size: screenWidth * 0.08),
        title: Text(title, style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold)),
        subtitle: Text(description, style: TextStyle(fontSize: screenWidth * 0.04)),
        trailing: Icon(Icons.arrow_forward_ios, size: screenWidth * 0.05, color: Colors.black),
        onTap: () {
          if(i==1) {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => Challenge()),
            );
          }
          else if (i==2){
            // Navigator.push(context,
            //   MaterialPageRoute(builder: (context) => RewardPage()),
            // );
          }
          else if (i==3){
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => referal()),
            );
          }
        },
      ),
    );
  }
}