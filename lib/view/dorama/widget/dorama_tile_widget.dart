import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/model/select_item_model.dart';
import 'package:brain_dump/util/tool_util.dart';
import 'package:brain_dump/view/dorama/dorama_form_view.dart';
import 'package:brain_dump/view/dorama/widget/dorama_delete_dialog_widget.dart';
import 'package:brain_dump/view/dorama/widget/memo_gage_widget.dart';
import 'package:brain_dump/view/memo/memo_slide_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoramaTileWidget extends StatelessWidget {
  final DoramaData data;
  final int count;
  final Function delete;
  //final DoramaDatabaseNotifier provider;
  const DoramaTileWidget({
    Key? key,
    required this.data,
    required this.count,
    required this.delete,
    //required this.provider,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _tile(data: data, context: context);
  }

  _tile({
    required DoramaData data,
    required BuildContext context,
  }) {
    SelectItemModel? category = ToolUtil.getDoramaCategory(data.categoryId);

    Color color = (category != null) ? category.color : Colors.black;
    return Card(
      child: Container(
        height: 80,
        child: ListTile(
          leading: Chip(
            backgroundColor: Colors.transparent,
            shape: StadiumBorder(
              side: BorderSide(
                color: color,
              ),
            ),
            label: Text(
              (category != null) ? category.name : '',
              style: TextStyle(
                color: color,
              ),
            ),
          ),
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MemoSlideView(dorama: data),
              ),
            );
          },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(data.title),
              MemoGageWidget(currentCount: count, maxCount: 50),
            ],
          ),
          trailing: GestureDetector(
            onTap: () => _action(context),
            behavior: HitTestBehavior.opaque,
            child: const Icon(Icons.more_horiz),
          ),
        ),
      ),
    );
  }

  Future<void> _action(BuildContext context) async {
    var result = await showMenu(
      context: context,
      position: _getPosition(context),
      items: <PopupMenuItem<String>>[
        /*
        PopupMenuItem<String>(
          value: 'card',
          child: Text("card_list".tr()),
        ),
        */
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
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DoramaFormView(
            data: data,
          ),
        ),
      );
    } else if (result == 'delete') {
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
    }
  }

  RelativeRect _getPosition(BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset topLeft = box.size.topLeft(box.localToGlobal(Offset.zero));
    return RelativeRect.fromLTRB(100, topLeft.dy, 0, 0);
  }
}
