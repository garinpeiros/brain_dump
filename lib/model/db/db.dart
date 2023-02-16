import 'dart:io';

import 'package:brain_dump/model/dorama_with_count_model.dart';
import 'package:brain_dump/model/memo_with_dorama_model.dart';
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

  static final MyDatabase _instance = MyDatabase();

  static MyDatabase getInstance() {
    return _instance;
  }

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;

  //全てのドラマデータを取得
  Future<List<DoramaData>> readAllDorama() => select(dorama).get();

  ///
  /// データを取得
  ///
  Future<List<DoramaWithCountModel>> fetchDorama({
    required int offset,
    required int limit,
  }) async {
    final amountMemos = memo.id.count();

    final query = select(dorama).join(
        [innerJoin(memo, memo.dId.equalsExp(dorama.id), useColumns: false)]);
    query
      ..addColumns([amountMemos])
      ..groupBy([memo.dId])
      ..limit(limit, offset: offset);
    query.orderBy([OrderingTerm.desc(dorama.id)]);

    var rows = await query.get();
    return rows
        .map((e) => DoramaWithCountModel(
              e.readTable(dorama),
              e.read(amountMemos),
            ))
        .toList();
    /*
    return (select(dorama)
          ..limit(limit, offset: offset)
          ..orderBy([(t) => OrderingTerm.desc(t.id)]))
        .get();
     */
  }

  ///
  /// ID指定でデータを取得
  ///
  Future<DoramaData> fetchDoramaById(int id) {
    return (select(dorama)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  //追加(ドラマ)
  Future<int> writeDorama(DoramaCompanion data) => into(dorama).insert(data);

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
  /// ドラマID単位でメモデータを取得
  ///
  Future<List<MemoData>> fetchMemoByDorama(int dId) => (select(memo)
        ..where((tbl) => tbl.dId.equals(dId))
        ..orderBy([(t) => OrderingTerm.desc(t.id)]))
      .get();

  //追加(メモ）
  Future writeMemo(MemoCompanion data) => into(memo).insert(data);

  //更新(メモ）
  Future updateMemo(MemoData data) => update(memo).replace(data);

  //削除(メモ）
  Future deleteMemo(int id) =>
      (delete(memo)..where((tbl) => tbl.id.equals(id))).go();

  ///
  /// メモデータを取得
  ///
  Future<List<MemoWithDoramaModel>> fetchMemo({
    required int offset,
    required int limit,
  }) async {
    final query = select(memo).join([
      leftOuterJoin(dorama, dorama.id.equalsExp(memo.dId)),
    ])
      ..limit(limit, offset: offset);
    query.orderBy([OrderingTerm.desc(memo.id)]);

    print(query.toString());

    var rows = await query.get();
    return rows
        .map((e) => MemoWithDoramaModel(
              e.readTable(memo),
              e.readTable(dorama),
            ))
        .toList();
    /*
    return items.map((rows) {
      return rows.map((row) {
        return MemoWithDoramaModel(
          row.readTable(memo),
          row.readTableOrNull(dorama),
        );
      }).toList();


     */
    /*
    return (select(memo)
          ..limit(limit, offset: offset)
          ..orderBy([(t) => OrderingTerm.desc(t.id)]))
        .get();

     */
  }

  //全削除(メモ)
  Future deleteAllMemo() => delete(memo).go();

  //dId指定でメモを削除
  Future deleteMemoByDId(int id) =>
      (delete(memo)..where((tbl) => tbl.dId.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
