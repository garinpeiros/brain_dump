import 'package:drift/drift.dart';

import '../model/db/db.dart';
import '../model/dorama_with_count_model.dart';

part 'dorama_dao.g.dart';

@DriftAccessor(tables: [Dorama, Memo])
class DoramaDao extends DatabaseAccessor<MyDatabase> with _$DoramaDaoMixin {
  DoramaDao(MyDatabase db) : super(db);

  Future<int> write(DoramaCompanion data) => into(dorama).insert(data);

  Future updateData(DoramaData data) => update(dorama).replace(data);

  Future deleteData(int id) =>
      (delete(dorama)..where((tbl) => tbl.id.equals(id))).go();

  Future deleteAll() => delete(dorama).go();

  ///
  /// 一覧データを取得
  ///
  Future<List<DoramaWithCountModel>> fetchData({
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
}
