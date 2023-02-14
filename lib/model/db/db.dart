import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';

/*
  String title;
  int c_id;
  int created_at;
  int updated_at;
  String documentId;
 */

class Dorama extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer()();
  TextColumn get title => text().withDefault(const Constant(''))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}

/*
  String d_id;
  String title;
  String content;
  int c_id;
  int created_at;
  int updated_at;
  String documentId;
  Future<Dorama> dorama;
 */

class Memo extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get content => text().withDefault(const Constant(''))();
  IntColumn get dId => integer()();
  IntColumn get categoryId => integer()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}

@DriftDatabase(tables: [Dorama, Memo])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;

  //全てのドラマデータを取得
  Future<List<DoramaData>> readAllDorama() => select(dorama).get();

  ///
  /// データを取得
  ///
  Future<List<DoramaData>> fetchDorama({
    required int offset,
    required int limit,
  }) {
    return (select(dorama)..limit(limit, offset: offset)).get();
  }

  //追加(ドラマ)
  Future writeDorama(DoramaCompanion data) => into(dorama).insert(data);

  //更新（ドラマ）
  Future updateDorama(DoramaData data) => update(dorama).replace(data);

  //削除（ドラマ）
  Future deleteDrama(int id) =>
      (delete(dorama)..where((tbl) => tbl.id.equals(id))).go();

  //全削除(ドラマ)
  Future deleteAllDorama() => delete(dorama).go();

  //全てのメモデータを取得
  Future<List<MemoData>> readAllMemo() => select(memo).get();

  ///
  /// ドラマID単位でデータを取得
  ///
  Future<List<MemoData>> fetchDataByDorama(int dId) =>
      (select(memo)..where((tbl) => tbl.dId.equals(dId))).get();

  //追加(メモ）
  Future writeMemo(MemoCompanion data) => into(memo).insert(data);

  //更新(メモ）
  Future updateMemo(MemoData data) => update(memo).replace(data);

  //削除(メモ）
  Future deleteMemo(int id) =>
      (delete(memo)..where((tbl) => tbl.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
