import 'package:floor/floor.dart';

@entity
class Categoria {
  @primaryKey
  final int id;

  final String titolo;

  Categoria(this.id, this.titolo);
}
