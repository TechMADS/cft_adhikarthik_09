import 'dart:async';
import 'package:carbon_footprint_tracker_by_teamtech_mads/History.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/Referal.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/Settings.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/authentication_page.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/homecontent.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/dashboard.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/reward_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'challenge.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/adding_devices.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/Coin.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/profilepage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _currentScreen = HomeContent(); // Default screen
  final PageController _pageController = PageController();
  final List<String> images = ['assets/offer1.jpg', 'assets/offer2.webp', 'assets/offer3.webp'];
  int currentPage = 0;
  String?username;
  String?email;


  void _onItemTapped(int index) {
    setState(() {
      if (index == 3) {
        _currentScreen = dashboard();
      } else if(index == 4) {
        _currentScreen = Challenge(); // Default content
      }
      else if(index == 2){
        _currentScreen = DevicesScreen();
      }
      else if(index == 1) {
        _currentScreen = RewardsPage() ; // Default content
      }
      else {
        _currentScreen = HomeContent();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (currentPage < images.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      _pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: "Select Date",
      initialEntryMode: DatePickerEntryMode.calendar,
    );

    if (pickedDate != null) {
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('HI! $username', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              color: Colors.orange,
              onPressed: () {
                setState(() {
                  _currentScreen = _pickDate() as Widget;
                });
              }, icon: Icon(Icons.calendar_month)),
          IconButton(
              color: Colors.orange,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CarbonCoinPage()),
                );},
              icon: Icon(Icons.currency_exchange)
          ),
        ],
      ),

      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('$username'),
              accountEmail: Text(email.toString()),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/profile.jpg"),
              ),
              decoration: BoxDecoration(color: Colors.orange),
            ),
            ListTile(
              leading: Icon(Icons.person,color: Colors.white), // Profile Icon
              title: Text("Profile"),textColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profilepage()), // Navigate to ProfilePage
                );
              },
            ),

            ListTile(leading: Icon(Icons.person_add_alt,color: Colors.white), title: Text('Referral'),textColor: Colors.white,
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => referal()));
              },
            ),
            ListTile(leading: Icon(Icons.timeline,color: Colors.white), title: Text('History'),textColor: Colors.white,
              onTap:(){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => history()),
                );
              },),
            ListTile(leading: Icon(Icons.settings,color: Colors.white), title: Text('Settings'),textColor: Colors.white,
            onTap: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => SettingsPage()),);
            },),
            ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: Text('Log Out'),
                textColor: Colors.red,
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> AuthScreen()),
                      (route) => false);
                  // await logout(context);
                }
            ),
          ],
        ),
      ),

      body: _currentScreen,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.orange), label: 'Home', backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard_sharp, color: Colors.orange), label: 'Rewards', backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_rounded, color: Colors.orange), label: 'New', backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard_rounded, color: Colors.orange), label: 'Dashboard', backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events, color: Colors.orange), label: 'Challenges', backgroundColor: Colors.black),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
}
