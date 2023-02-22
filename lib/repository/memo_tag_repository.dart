import '../model/db/db.dart';

class MemoTagRepository {
  late MyDatabase _db;
  MemoTagRepository() {
    _db = MyDatabase.getInstance();
  }
  Future<List<LinkTagData>> fetchTagByMemo(int memoId) =>
      _db.tagRelationDao.fetchTagByMemo(memoId);
  Future<int> add(LinkTagRelationCompanion data) =>
      _db.tagRelationDao.add(data);
  Future<void> remove({required int memoId, required int tagId}) =>
      _db.tagRelationDao.remove(memoId: memoId, tagId: tagId);
}
