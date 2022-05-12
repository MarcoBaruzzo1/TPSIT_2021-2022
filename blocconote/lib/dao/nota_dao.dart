import '../entity/nota.dart';
import 'package:floor/floor.dart';

@dao
abstract class NotaDao {
  @Query('SELECT * FROM Nota')
  Future<List<Nota>> findAllNota();

  @Query('SELECT * FROM Nota WHERE id = :id')
  Stream<Nota?> findNotaById(int id);

  @insert
  Future<void> insertNota(Nota nota);

  @Query('DELETE FROM Nota')
  Future<void> deleteAllNota();

  @Query('DELETE FROM Nota WHERE id= :id')
  Future<void> deleteNotaById(int id);

   @Query('DELETE FROM Nota WHERE categoriaId= :catid')
  Future<void> deleteNotaByCategoriaId(int catid);
}
