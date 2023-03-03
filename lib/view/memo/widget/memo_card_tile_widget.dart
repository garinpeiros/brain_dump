import 'package:brain_dump/config/category_config.dart';
import 'package:brain_dump/model/memo_with_dorama_model.dart';
import 'package:brain_dump/util/tool_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../model/db/db.dart';

class MemoCardTileWidget extends StatelessWidget {
  final MemoWithDoramaModel data;
  final VoidCallback onTap;

  const MemoCardTileWidget({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
        child: _card(data),
      ),
    );
  }

  Widget _card(MemoWithDoramaModel data) {
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
                  data.memo.title ?? '',
                  style: TextStyle(
                    color:
                        ToolUtil.getMemoCategory(data.memo.categoryId)!.color,
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
            child: _getTitle(data.dorama),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: FractionalOffset.bottomRight,
            child: Text(
              ToolUtil.convertDate(data.memo.updatedAt),
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

  Widget _getTitle(DoramaData dorama) {
    final category = doramaCategoryItems
        .firstWhereOrNull((element) => element.id == dorama.categoryId);

    final String name = (category != null) ? category.name : '';
    final Color color = (category != null) ? category.color : Colors.black;

    return RichText(
      text: TextSpan(
        text: dorama.title ?? '',
        style: const TextStyle(color: Colors.black, fontSize: 15),
        children: <TextSpan>[
          TextSpan(
            text: ' / $name',
            style: TextStyle(color: color, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
