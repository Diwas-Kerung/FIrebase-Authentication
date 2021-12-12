import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:slide/Auth/home.dart';
import 'package:slide/Auth/login.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Slide());
}

class Slide extends StatelessWidget {
   Slide({ Key? key }) : super(key: key);
  final Future<FirebaseApp> _initialize = Firebase.initializeApp();
  final storage = const FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: 'uid');
    if(value == null){
      return false;
    }else{
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialize,
      builder: (context, snapshot){
        if(snapshot.hasError){
          print('Something went wrong!');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        return GetMaterialApp(
          title: 'Slide',
          theme: ThemeData.dark(),
          home: FutureBuilder(
            future: checkLoginStatus(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
              if(snapshot.data == false){
                return const Login();
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }
              return const Home();
          },),
        );
      },
    );
  }
}