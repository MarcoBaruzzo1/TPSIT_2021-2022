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

class TagPage extends StatefulWidget {
  const TagPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  late AppDatabase _db;
  List<Tag> _tag = <Tag>[];
  @override
  void initState() {
    super.initState();
    loadDatabase();
  }

  void loadDatabase() {
    _tag = [];
    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((db) => {
          db.tagDao.findAllTags().then((data) async {
            setState(() {
              _db = db;
              _tag = data;
            });
          })
        });
  }

  void deleteTag(int id) {
    setState(() {
      _db.tagDao.deleteTagById(id);
      _db.notatagDao.deleteNotaTagByTagId(id);
      loadDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elenco tag'),
      ),
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
                    itemCount: _tag.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onDoubleTap: () => deleteTag(index),
                        child: Dismissible(
                          key: Key(_tag[index].titolo),
                          onDismissed: (direction) {
                            deleteTag(_tag[index].id);
                          },
                          background: Container(color: Colors.red),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Text(_tag[index].titolo),
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
