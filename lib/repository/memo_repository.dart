import 'package:brain_dump/model/memo_with_dorama_model.dart';

import '../model/db/db.dart';

class MemoRepository {
  late MyDatabase _db;
  MemoRepository() {
    _db = MyDatabase.getInstance();
  }

  Future<List<MemoData>> fetchDataByDorama(int dId) =>
      _db.memoDao.fetchDataByDorama(dId);

  Future<void> write(MemoCompanion data) => _db.memoDao.write(data);
  Future<void> update(MemoData data) => _db.memoDao.updateData(data);
  Future<void> delete(int id) => _db.memoDao.deleteData(id);
  Future<void> deleteAll() => _db.memoDao.deleteAll();
  Future<List<MemoWithDoramaModel>> fetch(
          {required int offset, required int limit}) =>
      _db.memoDao.fetchDataWithDorama(offset: offset, limit: limit);
  Future<void> deleteByDId(int id) => _db.memoDao.deleteByDId(id);
  Future<int> count() => _db.memoDao.countData();
}
