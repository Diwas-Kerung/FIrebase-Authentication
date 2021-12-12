import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide/Auth/login.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void signout() async {
    await FirebaseAuth.instance.signOut();
    Get.off(const Login());
  }
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    print(user);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(user!.uid),
            Center(
              child: ElevatedButton(onPressed: (){
                signout();
              }, child: const Text('Sign out')),
            ),
          ],
        ),
      ),
    );
  }
}