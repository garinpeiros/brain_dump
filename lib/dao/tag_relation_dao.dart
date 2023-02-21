import 'package:drift/drift.dart';

import '../model/db/db.dart';

part 'tag_relation_dao.g.dart';

@DriftAccessor(tables: [Dorama, Memo, LinkTag, LinkTagRelation])
class TagDao extends DatabaseAccessor<MyDatabase> with _$TagDaoMixin {
  TagDao(MyDatabase db) : super(db);

  ///
  /// メモデータとタグデータ紐づけ
  ///
  Future<int> add(LinkTagRelationCompanion data) =>
      into(linkTagRelation).insert(data);

  ///
  /// メモデータとタグデータ紐づけ
  ///
  Future<void> remove({required int memoId, required int tagId}) =>
      (delete(linkTagRelation)
            ..where((tbl) => tbl.memoId.equals(memoId))
            ..where((tbl) => tbl.tagId.equals(tagId)))
          .go();
}
