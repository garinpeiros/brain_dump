import 'package:brain_dump/model/memo_with_dorama_model.dart';

import '../model/db/db.dart';

class MemoRepository {
  late MyDatabase _db;
  MemoRepository() {
    _db = MyDatabase.getInstance();
  }

  Future<List<MemoData>> fetchDataByDorama(int dId) =>
      _db.fetchMemoByDorama(dId);

  Future<void> write(MemoCompanion data) => _db.writeMemo(data);
  Future<void> update(MemoData data) => _db.updateMemo(data);
  Future<void> delete(int id) => _db.deleteMemo(id);
  Future<void> deleteAll() => _db.deleteAllMemo();
  Future<List<MemoWithDoramaModel>> fetch(
          {required int offset, required int limit}) =>
      _db.fetchMemo(offset: offset, limit: limit);
  Future<void> deleteByDId(int id) => _db.deleteMemoByDId(id);
}
