import 'dart:io';

import 'package:brain_dump/model/dorama_with_count_model.dart';
import 'package:brain_dump/model/memo_with_dorama_model.dart';
import 'package:brain_dump/model/tag_with_count_model.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../config/constant_config.dart';

part 'db.g.dart';

class Dorama extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer()();
  TextColumn get title => text().withDefault(const Constant(''))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}

class Memo extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get content => text().withDefault(const Constant(''))();
  IntColumn get dId => integer()();
  IntColumn get categoryId => integer()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}

class LinkTag extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withDefault(const Constant(''))();
  IntColumn get colorId => integer()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}

class LinkTagRelation extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tagId => integer()();
  IntColumn get memoId => integer()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}

@DriftDatabase(tables: [Dorama, Memo, LinkTag, LinkTagRelation])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  static final MyDatabase _instance = MyDatabase();

  static MyDatabase getInstance() {
    return _instance;
  }

  LazyDatabase reset() {
    return _openConnection();
  }

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          await m.createTable(linkTag);
          await m.createTable(linkTagRelation);
        }
      },
    );
  }

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

    final query = select(dorama).join([
      leftOuterJoin(memo, memo.dId.equalsExp(dorama.id), useColumns: false)
    ]);
    query
      ..addColumns([amountMemos])
      ..groupBy([dorama.id])
      ..limit(limit, offset: offset);
    query.orderBy([OrderingTerm.desc(dorama.id)]);

    var rows = await query.get();
    return rows
        .map((e) => DoramaWithCountModel(
              e.readTable(dorama),
              e.read(amountMemos),
            ))
        .toList();
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
    var rows = await query.get();
    return rows
        .map((e) => MemoWithDoramaModel(
              e.readTable(memo),
              e.readTable(dorama),
            ))
        .toList();
  }

  //全削除(メモ)
  Future deleteAllMemo() => delete(memo).go();

  //dId指定でメモを削除
  Future deleteMemoByDId(int id) =>
      (delete(memo)..where((tbl) => tbl.dId.equals(id))).go();

  ///
  /// 登録データをカウント
  ///
  Future<int> countMemo() async {
    var countExp = memo.id.count();
    final query = selectOnly(memo)..addColumns([countExp]);
    return await query.map((row) => row.read(countExp)).getSingle();
  }

  //追加(タグ)
  Future<int> writeLinkTag(LinkTagCompanion data) => into(linkTag).insert(data);

  ///
  /// タグデータを取得
  ///
  Future<List<TagWithCountModel>> fetchTag({
    required int offset,
    required int limit,
  }) async {
    final amountMemos = linkTagRelation.id.count();

    final query = select(linkTag).join([
      leftOuterJoin(
          linkTagRelation, linkTag.id.equalsExp(linkTagRelation.tagId),
          useColumns: false)
    ]);
    query
      ..addColumns([amountMemos])
      ..groupBy([linkTag.id])
      ..limit(limit, offset: offset);
    query.orderBy([OrderingTerm.desc(linkTag.id)]);

    var rows = await query.get();
    return rows
        .map((e) => TagWithCountModel(
              e.readTable(linkTag),
              e.read(amountMemos),
            ))
        .toList();
  }

  //追加(タグ）
  Future<int> writeTag(LinkTagCompanion data) => into(linkTag).insert(data);

  //更新(タグ）
  Future updateTag(LinkTagData data) => update(linkTag).replace(data);

  //削除(タグ）
  Future deleteTag(int id) async {
    (delete(linkTag)..where((tbl) => tbl.id.equals(id))).go();
    (delete(linkTagRelation)..where((tbl) => tbl.tagId.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, dbFileName));
    return NativeDatabase(file);
  });
}
