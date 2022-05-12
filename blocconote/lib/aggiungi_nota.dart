import 'package:blocconote/database.dart';
import 'package:blocconote/entity/categoria.dart';
import 'package:blocconote/entity/nota.dart';
import 'package:blocconote/entity/nota_tag.dart';
import 'package:flutter/material.dart';

import 'entity/tag.dart';

class AggiungiNotaPage extends StatefulWidget {
  const AggiungiNotaPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AggiungiNotaPage> createState() => _AggiungiNotaPageState();
}

class _AggiungiNotaPageState extends State<AggiungiNotaPage> {
  TextEditingController titoloController = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  String? dropdown_scelta = "Nessuna";
  List<String> _categorie = [];
  List<Categoria> _categorieDb = [];
  late AppDatabase _db;

  void _addNote() async {
    List<Nota> note = await _db.notaDao.findAllNota();
    int idNota = 1;
    for (Nota n in note) {
      if (n.id >= idNota) idNota = n.id + 1;
    }
    String titoloNota = titoloController.text;
    String testoNota = textController.text;
    int idCategoriaNota = -1;
    if (dropdown_scelta != "Nessuna") {
      for (Categoria c in _categorieDb) {
        if (c.titolo == dropdown_scelta) idCategoriaNota = c.id;
      }
    }
    
    _db.notaDao.insertNota(Nota(idNota, titoloNota, testoNota, idCategoriaNota));
    //collego tag alla nota e se un tag è nuova lo aggiungo al db
    String tags = tagsController.text;
    tags.replaceAll(' ', '');
    List<String> tagsList = tagsController.text.split(',');
    List<Tag> tagsDb = await _db.tagDao.findAllTags();
    int idTag = -1;
    List<NotaTag> ntags=await _db.notatagDao.findAllNotaTag();
    int idNotaTagLast=1;
    for(NotaTag nt in ntags){
      if(nt.id>=idNotaTagLast)idNotaTagLast=nt.id;
    }
    for (String tag in tagsList) {
      //controllo se il tag è già presente nel db
      for (Tag tagDb in tagsDb) {
        if (tag.toLowerCase() == tagDb.titolo.toLowerCase()) {
          //il tag esiste già nel db nella tabella tag e allora lo collego alla nota
          idTag = tagDb.id;
        }
      }
      if (idTag == -1) {
        //non ho trovato il tag nel db quindi lo creo
        int idNewTag = 0;
        for (Tag t in tagsDb) {
          if (t.id >= idNewTag) idNewTag = t.id + 1;
        }
        idTag=idNewTag;
        _db.tagDao.insertTag(Tag(idNewTag, tag));
      }
      //collego la nota al tag
      int idNotaTag=idNotaTagLast+1;
      idNotaTagLast=idNotaTag;
      _db.notatagDao.insertNotaTag(NotaTag(idNotaTag,idNota,idTag));
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _categorie.add("Nessuna");
    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((db) => {
          db.categoriaDao.findAllCategorie().then((data) => setState(() {
                _db = db;
                _categorieDb = data;
                for (Categoria cat in data) {
                  _categorie.add(cat.titolo);
                }
              }))
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Aggiungi note'),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.save), onPressed: () => {_addNote()}),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: titoloController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Titolo',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Testo',
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(20),
              child: DropdownButton<String>(
                value: dropdown_scelta,
                icon: const Icon(Icons.arrow_downward_outlined),
                underline: Container(height: 2, color: Colors.blueAccent),
                onChanged: (String? categoriaScelta) {
                  dropdown_scelta = categoriaScelta;
                  setState(() {
                    
                  });
                },
                items: _categorie.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: tagsController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tags(inserire più tag separati da una virgola)',
              ),
            ),
          ),
        ]));
  }
}
