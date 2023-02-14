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

  Future<void> deleteAll() => _db.deleteAllDorama();
  Future<void> writeData(DoramaCompanion data) => _db.writeDorama(data);
}
