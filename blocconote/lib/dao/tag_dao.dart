import '../entity/tag.dart';
import 'package:floor/floor.dart';

@dao
abstract class TagDao {
  @Query('SELECT * FROM Tag')
  Future<List<Tag>> findAllTags();

  @Query('SELECT * FROM Tag WHERE id = :id')
  Stream<Tag?> findTagById(int id);

  @insert
  Future<void> insertTag(Tag tag);

  @Query('DELETE FROM Tag')
  Future<void> deleteAllTag();

  @Query('DELETE FROM Tag WHERE id= :id')
  Future<void> deleteTagById(int id);
}
