import '../model/db/db.dart';

class MemoRepository {
  late MyDatabase _db;
  MemoRepository() {
    _db = MyDatabase.getInstance();
  }

  Future<List<MemoData>> fetchDataByDorama(int dId) =>
      _db.fetchDataByDorama(dId);

  Future<void> writeData(MemoCompanion data) => _db.writeMemo(data);
  Future<void> updateData(MemoData data) => _db.updateMemo(data);
  Future<void> deleteData(int id) => _db.deleteMemo(id);
}
