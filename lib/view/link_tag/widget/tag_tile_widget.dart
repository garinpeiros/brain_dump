import 'package:brain_dump/config/constant_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../model/db/db.dart';

class TagTileWidget extends StatelessWidget {
  final LinkTagData data;
  final int count;
  final Function delete;

  const TagTileWidget({
    Key? key,
    required this.data,
    required this.count,
    required this.delete,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _tile(data: data, context: context);
  }

  _tile({
    required LinkTagData data,
    required BuildContext context,
  }) {
    return Card(
      child: ListTile(
        leading: Text(
          '#',
          style: TextStyle(
            color: HexColor(baseColor),
          ),
        ),
        onTap: () async {
          /*
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MemoSlideView(dorama: data),
              ),
            );
            */
        },
        title: Text(data.title),
        trailing: GestureDetector(
          onTap: () => _action(context),
          behavior: HitTestBehavior.opaque,
          child: const Icon(Icons.more_horiz),
        ),
      ),
    );
  }

  Future<void> _action(BuildContext context) async {
    var result = await showMenu(
      context: context,
      position: _getPosition(context),
      items: <PopupMenuItem<String>>[
        PopupMenuItem<String>(
          value: 'edit',
          child: Text("edit".tr()),
        ),
        PopupMenuItem<String>(
          value: 'delete',
          child: Text("delete".tr()),
        ),
      ],
      elevation: 8.0,
    );

    if (result == 'edit') {
      /*
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DoramaFormView(
            data: data,
          ),
        ),
      );
       */
    } else if (result == 'delete') {
      /*
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DoramaDeleteDialogWidget(
            data: data,
            action: () async {
              await delete();
            },
          );
        },
      );
      */
    }
  }

  RelativeRect _getPosition(BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset topLeft = box.size.topLeft(box.localToGlobal(Offset.zero));
    return RelativeRect.fromLTRB(100, topLeft.dy, 0, 0);
  }
}
