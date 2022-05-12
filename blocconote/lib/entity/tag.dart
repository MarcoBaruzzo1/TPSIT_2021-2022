import 'package:floor/floor.dart';

@entity
class Tag {
  @primaryKey
  final int id;

  final String titolo;

  Tag(this.id, this.titolo);
}
