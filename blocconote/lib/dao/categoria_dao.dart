import '../entity/categoria.dart';
import 'package:floor/floor.dart';

@dao
abstract class CategoriaDao {
  @Query('SELECT * FROM Categoria')
  Future<List<Categoria>> findAllCategorie();

  @Query('SELECT * FROM Categoria WHERE id = :id')
  Future<Categoria?> findCategoriaById(int id);

  @insert
  Future<void> insertCategoria(Categoria cat);

  @Query('DELETE FROM Categoria')
  Future<void> deleteAllCategoria();

  @Query('DELETE FROM Categoria WHERE id= :id')
  Future<void> deleteCategoriaById(int id);
}
