import 'package:blocconote/notepage.dart';
import 'package:blocconote/categorie.dart';
import 'package:blocconote/elenco_tag.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blocco Note',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Database Baruzzo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blocco note'),
        ),
        body: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  color: Colors.blue,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(top: 50, bottom: 50, left: 0, right: 0),
                  child: Center(
                      child: Text(
                    "Note",
                    style: TextStyle(fontSize: 50),
                  )),
                ),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotePage(title: "Categorie")))
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  color: Colors.blueAccent,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(top: 50, bottom: 50, left: 0, right: 0),
                  child: Center(
                      child: Text(
                    "Categorie",
                    style: TextStyle(fontSize: 50),
                  )),
                ),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Categorie(title: "Categorie")))
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  color: Colors.blueGrey,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(top: 50, bottom: 50, left: 0, right: 0),
                  child: Center(
                      child: Text(
                    "Tag",
                    style: TextStyle(fontSize: 50),
                  )),
                ),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TagPage(title: "Tag")))
                },
              )
            ],
          ),
        ]));
  }
}
