// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NotaDao? _notaDaoInstance;

  CategoriaDao? _categoriaDaoInstance;

  TagDao? _tagDaoInstance;

  NotaTagDao? _notatagDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Nota` (`id` INTEGER NOT NULL, `titolo` TEXT NOT NULL, `testo` TEXT NOT NULL, `categoriaId` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Categoria` (`id` INTEGER NOT NULL, `titolo` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Tag` (`id` INTEGER NOT NULL, `titolo` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NotaTag` (`id` INTEGER NOT NULL, `idNota` INTEGER NOT NULL, `idTag` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NotaDao get notaDao {
    return _notaDaoInstance ??= _$NotaDao(database, changeListener);
  }

  @override
  CategoriaDao get categoriaDao {
    return _categoriaDaoInstance ??= _$CategoriaDao(database, changeListener);
  }

  @override
  TagDao get tagDao {
    return _tagDaoInstance ??= _$TagDao(database, changeListener);
  }

  @override
  NotaTagDao get notatagDao {
    return _notatagDaoInstance ??= _$NotaTagDao(database, changeListener);
  }
}

class _$NotaDao extends NotaDao {
  _$NotaDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _notaInsertionAdapter = InsertionAdapter(
            database,
            'Nota',
            (Nota item) => <String, Object?>{
                  'id': item.id,
                  'titolo': item.titolo,
                  'testo': item.testo,
                  'categoriaId': item.categoriaId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Nota> _notaInsertionAdapter;

  @override
  Future<List<Nota>> findAllNota() async {
    return _queryAdapter.queryList('SELECT * FROM Nota',
        mapper: (Map<String, Object?> row) => Nota(
            row['id'] as int,
            row['titolo'] as String,
            row['testo'] as String,
            row['categoriaId'] as int));
  }

  @override
  Stream<Nota?> findNotaById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Nota WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Nota(
            row['id'] as int,
            row['titolo'] as String,
            row['testo'] as String,
            row['categoriaId'] as int),
        arguments: [id],
        queryableName: 'Nota',
        isView: false);
  }

  @override
  Future<void> deleteAllNota() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Nota');
  }

  @override
  Future<void> deleteNotaById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Nota WHERE id= ?1', arguments: [id]);
  }

  @override
  Future<void> deleteNotaByCategoriaId(int catid) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Nota WHERE categoriaId= ?1',
        arguments: [catid]);
  }

  @override
  Future<void> insertNota(Nota nota) async {
    await _notaInsertionAdapter.insert(nota, OnConflictStrategy.abort);
  }
}

class _$CategoriaDao extends CategoriaDao {
  _$CategoriaDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _categoriaInsertionAdapter = InsertionAdapter(
            database,
            'Categoria',
            (Categoria item) =>
                <String, Object?>{'id': item.id, 'titolo': item.titolo});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Categoria> _categoriaInsertionAdapter;

  @override
  Future<List<Categoria>> findAllCategorie() async {
    return _queryAdapter.queryList('SELECT * FROM Categoria',
        mapper: (Map<String, Object?> row) =>
            Categoria(row['id'] as int, row['titolo'] as String));
  }

  @override
  Future<Categoria?> findCategoriaById(int id) async {
    return _queryAdapter.query('SELECT * FROM Categoria WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Categoria(row['id'] as int, row['titolo'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllCategoria() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Categoria');
  }

  @override
  Future<void> deleteCategoriaById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Categoria WHERE id= ?1', arguments: [id]);
  }

  @override
  Future<void> insertCategoria(Categoria cat) async {
    await _categoriaInsertionAdapter.insert(cat, OnConflictStrategy.abort);
  }
}

class _$TagDao extends TagDao {
  _$TagDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _tagInsertionAdapter = InsertionAdapter(
            database,
            'Tag',
            (Tag item) =>
                <String, Object?>{'id': item.id, 'titolo': item.titolo},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Tag> _tagInsertionAdapter;

  @override
  Future<List<Tag>> findAllTags() async {
    return _queryAdapter.queryList('SELECT * FROM Tag',
        mapper: (Map<String, Object?> row) =>
            Tag(row['id'] as int, row['titolo'] as String));
  }

  @override
  Stream<Tag?> findTagById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Tag WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Tag(row['id'] as int, row['titolo'] as String),
        arguments: [id],
        queryableName: 'Tag',
        isView: false);
  }

  @override
  Future<void> deleteAllTag() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Tag');
  }

  @override
  Future<void> deleteTagById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Tag WHERE id= ?1', arguments: [id]);
  }

  @override
  Future<void> insertTag(Tag tag) async {
    await _tagInsertionAdapter.insert(tag, OnConflictStrategy.abort);
  }
}

class _$NotaTagDao extends NotaTagDao {
  _$NotaTagDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _notaTagInsertionAdapter = InsertionAdapter(
            database,
            'NotaTag',
            (NotaTag item) => <String, Object?>{
                  'id': item.id,
                  'idNota': item.idNota,
                  'idTag': item.idTag
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NotaTag> _notaTagInsertionAdapter;

  @override
  Future<List<NotaTag>> findAllNotaTag() async {
    return _queryAdapter.queryList('SELECT * FROM NotaTag',
        mapper: (Map<String, Object?> row) => NotaTag(
            row['id'] as int, row['idNota'] as int, row['idTag'] as int));
  }

  @override
  Future<NotaTag?> findNotaTagById(int id) async {
    return _queryAdapter.query('SELECT * FROM NotaTag WHERE id = ?1',
        mapper: (Map<String, Object?> row) => NotaTag(
            row['id'] as int, row['idNota'] as int, row['idTag'] as int),
        arguments: [id]);
  }

  @override
  Future<List<NotaTag?>> findNotaTagByNotaId(int notaid) async {
    return _queryAdapter.queryList('SELECT * FROM NotaTag WHERE  idNota= ?1',
        mapper: (Map<String, Object?> row) => NotaTag(
            row['id'] as int, row['idNota'] as int, row['idTag'] as int),
        arguments: [notaid]);
  }

  @override
  Future<void> deleteAllNotaTag() async {
    await _queryAdapter.queryNoReturn('DELETE FROM NotaTag');
  }

  @override
  Future<void> deleteNotaTagById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM NotaTag WHERE id= ?1', arguments: [id]);
  }

  @override
  Future<void> deleteNotaTagByNotaId(int notaid) async {
    await _queryAdapter.queryNoReturn('DELETE FROM NotaTag WHERE idNota= ?1',
        arguments: [notaid]);
  }

  @override
  Future<void> deleteNotaTagByTagId(int tagid) async {
    await _queryAdapter.queryNoReturn('DELETE FROM NotaTag WHERE idTag= ?1',
        arguments: [tagid]);
  }

  @override
  Future<void> insertNotaTag(NotaTag nt) async {
    await _notaTagInsertionAdapter.insert(nt, OnConflictStrategy.abort);
  }
}
