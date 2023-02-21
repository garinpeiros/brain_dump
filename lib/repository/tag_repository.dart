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
      _db.fetchTag(offset: offset, limit: limit);

  Future<void> update(LinkTagData data) => _db.updateTag(data);
  Future<void> delete(int id) => _db.deleteTag(id);
  Future<int> write(LinkTagCompanion data) => _db.writeTag(data);
}
