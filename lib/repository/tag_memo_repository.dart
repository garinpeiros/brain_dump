import 'package:brain_dump/model/memo_with_dorama_model.dart';

import '../model/db/db.dart';

class TagMemoRepository {
  late MyDatabase _db;
  TagMemoRepository() {
    _db = MyDatabase.getInstance();
  }
  Future<List<MemoWithDoramaModel>> fetchMemoByTag(int tagId) =>
      _db.tagRelationDao.fetchMemoByTag(tagId);
}
