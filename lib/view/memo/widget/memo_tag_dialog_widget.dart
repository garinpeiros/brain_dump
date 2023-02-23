import 'package:brain_dump/config/constant_config.dart';
import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/view_model/tag/memo_tag_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MemoTagDialogWidget extends HookConsumerWidget {
  final MemoData memo;

  MemoTagDialogWidget(this.memo);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(16),
      children: <Widget>[
        _main(ref: ref, memo: memo, context: context),
      ],
    );
  }

  Widget _main(
      {required WidgetRef ref,
      required MemoData memo,
      required BuildContext context}) {
    return ref.watch(tagListFutureProvider).when(
          data: (list) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: _tagList(ref: ref, list: list, memo: memo),
            );
          },
          error: (error, _) => Container(),
          loading: () => Container(),
        );
  }

  ///
  /// タグ一覧
  ///
  _tagList({
    required WidgetRef ref,
    required List<LinkTagData> list,
    required MemoData memo,
  }) {
    ref.watch(memoTagTagDatabaseProvider(memo));
    MemoTagDatabaseNotifier provider =
        ref.watch(memoTagTagDatabaseProvider(memo).notifier);

    var items = provider.state.tagItems;
    var tags = list;
    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: tags
          .map((tag) {
            final isSelected = items.contains(tag);
            return InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(32)),
              onTap: () {
                if (isSelected) {
                  provider.remove(tagId: tag.id, memoId: memo.id);
                } else {
                  provider.add(tag: tag, memoId: memo.id);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  border: Border.all(
                    width: 2,
                    color: HexColor(tagColor),
                  ),
                  color: isSelected ? HexColor(tagColor) : null,
                ),
                child: Text(
                  tag.title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : HexColor(tagColor),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          })
          .cast<Widget>()
          .toList(),
    );
  }
}
