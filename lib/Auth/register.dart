import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/route_manager.dart';
import 'package:slide/Auth/home.dart';
import 'package:slide/Auth/login.dart';

class Register extends StatelessWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    const storage = FlutterSecureStorage();

    void signUp(String email, String password) async {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
            print(userCredential);
        await storage.write(key: 'uid', value: userCredential.user!.uid);
        Get.off(const Home());
      } on FirebaseAuthException catch (e) {  
        print(e.code.toString());
      }
    }

    void validate() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == '' || password == '') {
        print('Please input all information');
      } else {
        signUp(email, password);
      }
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a new email address',
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a new password',
            ),
          ),
          ElevatedButton(
              onPressed: () {
                validate();
              },
              child: const Text('Sign up'),),
          TextButton(onPressed: (){
            Get.off(const Login());
          }, child: const Text('Login'),),
        ],
      ),
    );
  }
}