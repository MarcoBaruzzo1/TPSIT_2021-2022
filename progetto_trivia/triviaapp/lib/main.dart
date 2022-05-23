import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:triviaapp/screen/quiz.dart';
import 'screen/home_screen.dart';
import 'screen/login_screen.dart';
import 'screen/signup_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override  
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Login app',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        SignupScreen.routeNname: (ctx) => SignupScreen(),
        LoginScreen.routeNname: (ctx) => LoginScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
      },
    );
  }
}