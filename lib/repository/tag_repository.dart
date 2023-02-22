import 'package:brain_dump/model/tag_with_count_model.dart';

import '../model/db/db.dart';

class TagRepository {
  late MyDatabase _db;
  TagRepository() {
    _db = MyDatabase.getInstance();
  }

  Future<List<TagWithCountModel>> fetchData({
    required int offset,
    required int limit,
  }) =>
      _db.tagDao.fetchData(offset: offset, limit: limit);

  Future<void> update(LinkTagData data) => _db.tagDao.updateData(data);
  Future<void> delete(int id) => _db.tagDao.deleteData(id);
  Future<int> write(LinkTagCompanion data) => _db.tagDao.write(data);
  Future<List<LinkTagData>> fetchAll() => _db.tagDao.fetchAll();
}
