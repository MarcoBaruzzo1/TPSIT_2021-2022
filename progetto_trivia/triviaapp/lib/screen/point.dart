import 'package:flutter/material.dart';
import 'package:triviaapp/screen/home_screen.dart';
import 'package:triviaapp/screen/login_screen.dart';

class PointScreen extends StatefulWidget {
  late int point_user;
  PointScreen({Key? key, required this.point_user}) : super(key: key);

  @override
  State<PointScreen> createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('score user: ${widget.point_user}', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
            SizedBox(height: 100,),
            ElevatedButton(
              onPressed: () {
                 Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen()));
              }, 
              child: Text('Return to home')),
               ElevatedButton(
              onPressed: () {
                 Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginScreen()));
              }, 
              child: Text('Logout')),
          ],
        ),
      ),
    );
  }
}
