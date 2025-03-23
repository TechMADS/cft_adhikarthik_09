import 'package:carbon_footprint_tracker_by_teamtech_mads/homepage.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Settings',style: TextStyle(color: Colors.white,fontSize: 28),),
      leading: IconButton(
          color:Colors.white,
          onPressed: (){
        Navigator.push(context,
        MaterialPageRoute(builder: (context)=> HomeScreen()),);
      }, icon:Icon(Icons.arrow_back)),
      backgroundColor: Colors.black,),


      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: ListView(
                  children: [
                    _buildSettingTile(Icons.person, 'Account', 'Manage your account'),
                    _buildSettingTile(Icons.notifications, 'Notifications', 'App notifications'),
                    _buildSettingTile(Icons.wifi, 'Connectivity', 'WiFi & Bluetooth settings'),
                    _buildSettingTile(Icons.privacy_tip, 'Privacy', 'Manage data permissions'),
                    _buildSettingTile(Icons.help, 'Help & Support', 'Get assistance'),
                    _buildSettingTile(Icons.info, 'About', 'App version & info'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, String subtitle) {
    return Card(
      color: Colors.orange,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, size: 28),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}