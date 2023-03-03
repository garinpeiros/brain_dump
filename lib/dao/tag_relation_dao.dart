import 'package:drift/drift.dart';

import '../model/db/db.dart';
import '../model/memo_with_dorama_model.dart';

part 'tag_relation_dao.g.dart';

@DriftAccessor(tables: [Dorama, Memo, LinkTag, LinkTagRelation])
class TagRelationDao extends DatabaseAccessor<MyDatabase>
    with _$TagRelationDaoMixin {
  TagRelationDao(MyDatabase db) : super(db);

  ///
  /// タグ指定でメモデータを取得
  ///
  Future<List<MemoWithDoramaModel>> fetchMemoByTag(int tagId) async {
    var inRows = await (select(memo).join([
      leftOuterJoin(linkTagRelation, linkTagRelation.memoId.equalsExp(memo.id)),
    ])..where(linkTagRelation.tagId.equals(tagId))).get();

    List<int?> list = inRows.map((e) => e.read(memo.id)).toList();

    final query = select(memo).join([
      leftOuterJoin(dorama, dorama.id.equalsExp(memo.dId)),
    ])..where(memo.id.isIn(list));
    query.orderBy([OrderingTerm.desc(memo.id)]);
    var rows = await query.get();
    return rows
        .map((e) => MemoWithDoramaModel(
      e.readTable(memo),
      e.readTable(dorama),
    ))
        .toList();
  }

  ///
  /// メモ指定でタグデータを取得
  ///
  Future<List<LinkTagData>> fetchTagByMemo(int memoId) async {
    final query = select(linkTag).join([
      innerJoin(linkTagRelation, linkTagRelation.tagId.equalsExp(linkTag.id),
          useColumns: false)
    ])
      ..where(linkTagRelation.memoId.equals(memoId));

    query.orderBy([OrderingTerm.desc(linkTagRelation.tagId)]);
    var rows = await query.get();
    return rows.map((e) => e.readTable(linkTag)).toList();
  }

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
