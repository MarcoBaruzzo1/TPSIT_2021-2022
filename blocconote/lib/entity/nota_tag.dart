import 'package:floor/floor.dart';

@entity
class NotaTag {
  @primaryKey
  final int id;

  final int idNota;
  final int idTag;

  NotaTag(this.id, this.idNota, this.idTag);
}
