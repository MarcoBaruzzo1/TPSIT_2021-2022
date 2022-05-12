import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotaWidget extends StatelessWidget {
  final int id;
  final String titolo;
  final String testo;
  final String categoria;
  String tags;

  NotaWidget(this.id, this.titolo, this.testo, this.categoria, this.tags);

  @override
  Widget build(BuildContext cxt) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.yellow,
          child: Row(
            children: <Widget>[
              Text(titolo, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
        Container(
          color: Colors.orange,
          child: Row(
            children: <Widget>[
              Text(testo, style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
        Container(
          color: Colors.orange,
          child: Row(
            children: <Widget>[
              Text("Categoria:" + categoria+"    -     "+ "tags:"+tags,
                  style: TextStyle(fontSize: 10)),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(5))
      ],
    ));
  }
}
