import 'package:blocconote/dao/categoria_dao.dart';
import 'package:blocconote/database.dart';
import 'package:blocconote/entity/categoria.dart';
import 'package:blocconote/entity/nota.dart';
import 'package:blocconote/entity/nota_tag.dart';
import 'package:flutter/material.dart';

import 'entity/tag.dart';

class AggiungiCategoria extends StatefulWidget {
  const AggiungiCategoria({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AggiungiCategoria> createState() => _AggiungiCategoriaState();
}

class _AggiungiCategoriaState extends State<AggiungiCategoria> {
  TextEditingController testoController = TextEditingController();
  void _addCategoria() async {
    AppDatabase db=await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    CategoriaDao cdao=db.categoriaDao;
    List<Categoria> categorie=await cdao.findAllCategorie();
    int id=0;
    for(Categoria cat in categorie){
      if(cat.id>=id)id=cat.id+1;
    }
    cdao.insertCategoria(Categoria(id, testoController.text));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Aggiungi note'),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.save), onPressed: () => {_addCategoria()}),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: testoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome categoria',
              ),
            ),
          ),
        ]));
  }
}
