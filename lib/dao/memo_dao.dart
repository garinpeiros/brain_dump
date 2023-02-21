import 'package:drift/drift.dart';

import '../model/db/db.dart';

part 'memo_dao.g.dart';

@DriftAccessor(tables: [Dorama, Memo])
class MemoDao extends DatabaseAccessor<MyDatabase> with _$MemoDaoMixin {
  MemoDao(MyDatabase db) : super(db);

  Future write(MemoCompanion data) => into(memo).insert(data);
  Future updateData(MemoData data) => update(memo).replace(data);
  Future deleteData(int id) =>
      (delete(memo)..where((tbl) => tbl.id.equals(id))).go();
}
