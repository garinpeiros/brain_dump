import 'dart:io';

import 'package:brain_dump/dao/tag_dao.dart';
import 'package:brain_dump/dao/tag_relation_dao.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../config/constant_config.dart';
import '../../dao/dorama_dao.dart';
import '../../dao/memo_dao.dart';

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

@DriftDatabase(tables: [
  Dorama,
  Memo,
  LinkTag,
  LinkTagRelation
], daos: [
  DoramaDao,
  MemoDao,
  TagDao,
  TagRelationDao,
])
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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, dbFileName));
    return NativeDatabase(file);
  });
}
