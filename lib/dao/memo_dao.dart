import 'package:drift/drift.dart';

import '../model/db/db.dart';
import '../model/memo_with_dorama_model.dart';

part 'memo_dao.g.dart';

@DriftAccessor(tables: [Dorama, Memo])
class MemoDao extends DatabaseAccessor<MyDatabase> with _$MemoDaoMixin {
  MemoDao(MyDatabase db) : super(db);

  Future write(MemoCompanion data) => into(memo).insert(data);
  Future updateData(MemoData data) => update(memo).replace(data);
  Future deleteData(int id) =>
      (delete(memo)..where((tbl) => tbl.id.equals(id))).go();

  ///
  /// ドラマID単位でメモデータを取得
  ///
  Future<List<MemoData>> fetchDataByDorama(int dId) => (select(memo)
        ..where((tbl) => tbl.dId.equals(dId))
        ..orderBy([(t) => OrderingTerm.desc(t.id)]))
      .get();

  ///
  /// メモデータを取得
  ///
  Future<List<MemoWithDoramaModel>> fetchDataWithDorama({
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
  Future deleteAll() => delete(memo).go();

  //dId指定でメモを削除
  Future deleteByDId(int id) =>
      (delete(memo)..where((tbl) => tbl.dId.equals(id))).go();

  ///
  /// 登録データをカウント
  ///
  Future<int> countData() async {
    var countExp = memo.id.count();
    final query = selectOnly(memo)..addColumns([countExp]);
    return await query.map((row) => row.read(countExp)).getSingle();
  }
}
