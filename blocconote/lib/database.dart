import 'dart:async';
import 'dao/categoria_dao.dart';
import 'dao/nota_tag_dao.dart';
import 'dao/tag_dao.dart';
import 'dao/nota_dao.dart';
import 'entity/categoria.dart';
import 'entity/nota.dart';
import 'entity/nota_tag.dart';
import 'entity/tag.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;



// the generated code will be there
// flutter packages pub run build_runner build
part 'database.g.dart';

@Database(version: 1, entities: [Nota, Categoria, Tag, NotaTag])
abstract class AppDatabase extends FloorDatabase {
  NotaDao get notaDao;
  CategoriaDao get categoriaDao;
  TagDao get tagDao;
  NotaTagDao get notatagDao;
}
