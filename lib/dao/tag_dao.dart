import 'package:drift/drift.dart';

import '../model/db/db.dart';
import '../model/tag_with_count_model.dart';

part 'tag_dao.g.dart';

@DriftAccessor(tables: [Dorama, Memo, LinkTag, LinkTagRelation])
class TagDao extends DatabaseAccessor<MyDatabase> with _$TagDaoMixin {
  TagDao(MyDatabase db) : super(db);

  Future<int> write(LinkTagCompanion data) => into(linkTag).insert(data);
  Future updateData(LinkTagData data) => update(linkTag).replace(data);
  Future deleteData(int id) async {
    (delete(linkTag)..where((tbl) => tbl.id.equals(id))).go();
    (delete(linkTagRelation)..where((tbl) => tbl.tagId.equals(id))).go();
  }

  Future<List<TagWithCountModel>> fetchData({
    required int offset,
    required int limit,
  }) async {
    final amountMemos = linkTagRelation.id.count();

    final query = select(linkTag).join([
      leftOuterJoin(
          linkTagRelation, linkTag.id.equalsExp(linkTagRelation.tagId),
          useColumns: false)
    ]);
    query
      ..addColumns([amountMemos])
      ..groupBy([linkTag.id])
      ..limit(limit, offset: offset);
    query.orderBy([OrderingTerm.desc(linkTag.id)]);

    var rows = await query.get();
    return rows
        .map((e) => TagWithCountModel(
              e.readTable(linkTag),
              e.read(amountMemos),
            ))
        .toList();
  }
}
