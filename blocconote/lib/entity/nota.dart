import 'package:floor/floor.dart';

@entity
class Nota {
  @primaryKey
  final int id;

  final String titolo;
  final String testo;
  final int categoriaId;

  Nota(this.id, this.titolo, this.testo, this.categoriaId);
}
