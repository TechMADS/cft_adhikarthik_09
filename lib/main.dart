import 'firebase_options.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


import 'globe_ani.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform) ;
  runApp(CO_Footprint_tracker());
}
class CO_Footprint_tracker extends StatelessWidget {
  const CO_Footprint_tracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder:(context,snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.data!=null){
              return const HomeScreen();
            }
            return const GlobeAnimationScreen();
          }
      ),
    );
  }
}
