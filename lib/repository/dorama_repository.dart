import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/model/dorama_with_count_model.dart';

class DoramaRepository {
  late MyDatabase _db;
  DoramaRepository() {
    _db = MyDatabase.getInstance();
  }

  Future<List<DoramaWithCountModel>> fetchData({
    required int offset,
    required int limit,
  }) =>
      _db.fetchDorama(offset: offset, limit: limit);

  Future<void> update(DoramaData data) => _db.updateDorama(data);
  Future<void> delete(int id) => _db.deleteDrama(id);
  Future<void> deleteAll() => _db.deleteAllDorama();
  Future<int> write(DoramaCompanion data) => _db.writeDorama(data);

  Future<DoramaData> fetchById(int id) => _db.fetchDoramaById(id);
}
