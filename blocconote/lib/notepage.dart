import 'package:blocconote/NotaWidget.dart';
import 'package:blocconote/aggiungi_nota.dart';
import 'package:blocconote/dao/nota_dao.dart';
import 'package:blocconote/database.dart';
import 'package:blocconote/entity/nota.dart';
import 'package:blocconote/entity/nota_tag.dart';
import 'package:blocconote/entity/tag.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late AppDatabase _db;
  late NotaDao _notadao;
  List<Nota> _note = <Nota>[];
  List<NotaWidget> _noteWidget = <NotaWidget>[];
  @override
  void initState() {
    super.initState();
    loadDatabase();
    
  }

  void loadDatabase(){
    _noteWidget=[];
    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((db) => {
          db.notaDao.findAllNota().then((data) async {
            setState(() {
              _db = db;
              _notadao = db.notaDao;
              _note = data;
            });
            for (int i = 0; i < _note.length; i++) {
              List<NotaTag?> ntags =
                  await _db.notatagDao.findNotaTagByNotaId(_note[i].id);
              List<Tag> tags = await _db.tagDao.findAllTags();
              String tags_nota = "";
              for (int j = 0; j < ntags.length; j++) {
                for (Tag t in tags) {
                  if (t.id == ntags[j]!.idTag) {
                    tags_nota += t.titolo + " ";
                  }
                }
              }
              String cat = "Nessuna";
              if (_note[i].categoriaId != -1){
                cat = (await _db.categoriaDao
                        .findCategoriaById(_note[i].categoriaId))!
                    .titolo;
              }
              _noteWidget.add(NotaWidget(_note[i].id, _note[i].titolo,
                  _note[i].testo, cat, tags_nota));
            }
            setState(() {});
          })
        });
  }
  void deleteNota(int index) {
    setState(() {
      int id=_noteWidget[index].id;
      _db.notaDao.deleteNotaById(id);
      _db.notatagDao.deleteNotaTagByNotaId(id);
      loadDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elenco note'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AggiungiNotaPage(title: "Aggiungi nota")));
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
                    itemCount: _noteWidget.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onDoubleTap: ()=>deleteNota(index),
                        child: _noteWidget[index],
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
