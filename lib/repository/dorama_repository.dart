import 'package:brain_dump/model/db/db.dart';

class DoramaRepository {
  late MyDatabase _db;
  DoramaRepository() {
    _db = MyDatabase();
  }

  Future<List<DoramaData>> fetchData({
    required int offset,
    required int limit,
  }) =>
      _db.fetchDorama(offset: offset, limit: limit);

  Future<void> update(DoramaData data) => _db.updateDorama(data);
  Future<void> delete(int id) => _db.deleteDrama(id);
  Future<void> deleteAll() => _db.deleteAllDorama();
  Future<void> writeData(DoramaCompanion data) => _db.writeDorama(data);
}
