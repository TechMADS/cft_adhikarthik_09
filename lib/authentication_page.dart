import 'package:carbon_footprint_tracker_by_teamtech_mads/onboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';



class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

// Function to check if the username already exists in Firestore
Future<bool> checkUsernameExists(String username) async {
  QuerySnapshot query = await FirebaseFirestore.instance
      .collection('users')
      .where('username', isEqualTo: username)
      .get();
  return query.docs.isNotEmpty;
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> handleAuth() async{
    if (isLogin){
      try {
        final userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
        print(userCredential);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } on FirebaseAuthException catch(e) {
        print(e.message);
      }


    } else {
      try {
        bool isUsernameTaken = await checkUsernameExists(nameController.text.trim());
        if (isUsernameTaken) {
          print("Username already exists. Try another.");
        }
        final userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        // Store user details in Firestore
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'username': nameController.text.trim(),
          'email': emailController.text.trim(),
          'uid': userCredential.user!.uid,
        });

        print(userCredential);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoard()));
      } on FirebaseAuthException catch(e) {
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isLogin ? 'Login' : 'Sign Up',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              if (!isLogin)
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                          },
                        icon: Icon(
                        isPasswordVisible? Icons.visibility : Icons.visibility_off,
                      ))
                ),
                obscureText: !isPasswordVisible,
              ),
              if (!isLogin)
                Column(
                  children: [
                    const SizedBox(height: 10),
                    TextField(
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                                });
                              },
                              icon: Icon(
                                isConfirmPasswordVisible? Icons.visibility : Icons.visibility_off,
                              ))
                      ),
                      obscureText: !isConfirmPasswordVisible,
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()async {
                  await handleAuth();
                },
                child: Text(isLogin ? 'Login' : 'Sign Up'),
              ),
              TextButton(
                onPressed: () => setState(() => isLogin = !isLogin),
                child: Text(isLogin ? "Don't have an account? Sign Up" : "Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}