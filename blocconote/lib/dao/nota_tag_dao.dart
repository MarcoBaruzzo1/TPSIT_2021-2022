import '../entity/nota_tag.dart';
import 'package:floor/floor.dart';

@dao
abstract class NotaTagDao {
  @Query('SELECT * FROM NotaTag')
  Future<List<NotaTag>> findAllNotaTag();

  @Query('SELECT * FROM NotaTag WHERE id = :id')
  Future<NotaTag?> findNotaTagById(int id);

  @Query('SELECT * FROM NotaTag WHERE  idNota= :notaid')
  Future<List<NotaTag?>> findNotaTagByNotaId(int notaid);

  @insert
  Future<void> insertNotaTag(NotaTag nt);

  @Query('DELETE FROM NotaTag')
  Future<void> deleteAllNotaTag();

  @Query('DELETE FROM NotaTag WHERE id= :id')
  Future<void> deleteNotaTagById(int id);

  @Query('DELETE FROM NotaTag WHERE idNota= :notaid')
  Future<void> deleteNotaTagByNotaId(int notaid);

  @Query('DELETE FROM NotaTag WHERE idTag= :tagid')
  Future<void> deleteNotaTagByTagId(int tagid);
}
