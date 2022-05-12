import 'package:blocconote/NotaWidget.dart';
import 'package:blocconote/aggiungi_categoria.dart';
import 'package:blocconote/aggiungi_nota.dart';
import 'package:blocconote/dao/nota_dao.dart';
import 'package:blocconote/database.dart';
import 'package:blocconote/entity/categoria.dart';
import 'package:blocconote/entity/nota.dart';
import 'package:blocconote/entity/nota_tag.dart';
import 'package:blocconote/entity/tag.dart';
import 'package:flutter/material.dart';

class Categorie extends StatefulWidget {
  const Categorie({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  late AppDatabase _db;
  List<Categoria> _categorie = <Categoria>[];
  @override
  void initState() {
    super.initState();
    loadDatabase();
  }

  void loadDatabase() {
    _categorie = [];
    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((db) => {
          db.categoriaDao.findAllCategorie().then((data) async {
            setState(() {
              _db = db;
              _categorie = data;
            });
          })
        });
  }

  void deleteCategoria(int id) {
    setState(() {
      _db.categoriaDao.deleteCategoriaById(id);
      _db.notaDao.deleteNotaByCategoriaId(id);
      loadDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elenco categorie'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AggiungiCategoria(title: "Aggiungi nota")));
            loadDatabase();
          }),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(5),
                    shrinkWrap: true,
                    itemCount: _categorie.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onDoubleTap: () => deleteCategoria(index),
                        child: Dismissible(
                          key: Key(_categorie[index].titolo),
                          onDismissed: (direction) {
                            deleteCategoria(_categorie[index].id);
                          },
                          background: Container(color: Colors.red),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Text(_categorie[index].titolo),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
