import 'package:brain_dump/config/category_config.dart';
import 'package:brain_dump/util/tool_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/db/db.dart';
import '../../../view_model/dorama/dorama_provider.dart';

class MemoCardTileWidget extends HookConsumerWidget {
  final MemoData memo;
  final VoidCallback onTap;

  const MemoCardTileWidget({
    Key? key,
    required this.memo,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(doramaDetailProvider(memo.dId)).when(
          data: (dorama) {
            if (dorama != null && dorama is DoramaData) {
              print("ok!!");
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: Container(
                  height: 100,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 16,
                        color: Colors.black12,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: _card(
                    dorama: dorama,
                    memo: memo,
                  ),
                ),
              );
            }
            return Container();
          },
          error: (error, _) => Container(),
          loading: () => Container(),
        );
  }

  Widget _card({required DoramaData dorama, required MemoData memo}) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: FractionalOffset.topLeft,
              child: DefaultTextStyle(
                style: const TextStyle(color: Colors.black),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                child: Text(
                  memo.title ?? '',
                  style: TextStyle(
                    color: ToolUtil.getMemoCategory(memo.categoryId)!.color,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 55,
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: FractionalOffset.topLeft,
            child: _getTitle(dorama, memo.categoryId),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: FractionalOffset.bottomRight,
            child: Text(
              ToolUtil.convertDate(memo.updatedAt),
              style: const TextStyle(
                fontSize: 10,
                fontFamily: "NotoSerifJP-SemiBold",
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getTitle(DoramaData dorama, int cId) {
    final category =
        doramaCategoryItems.firstWhere((element) => element.id == cId);
    return RichText(
      text: TextSpan(
        text: dorama.title ?? '',
        style: const TextStyle(color: Colors.black, fontSize: 15),
        children: <TextSpan>[
          TextSpan(
            text: ' / ${category.name}',
            style: TextStyle(color: category.color, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
