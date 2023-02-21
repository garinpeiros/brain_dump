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
      _db.doramaDao.fetchData(offset: offset, limit: limit);
  Future<void> update(DoramaData data) => _db.doramaDao.updateData(data);
  Future<void> delete(int id) => _db.doramaDao.deleteData(id);
  Future<void> deleteAll() => _db.doramaDao.deleteAll();
  Future<int> write(DoramaCompanion data) => _db.doramaDao.write(data);
}
