import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/util/tool_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widget/delete_dialog_widget.dart';
import '../memo_form_view.dart';
import 'memo_tag_dialog_widget.dart';

class MemoCardWidget extends StatelessWidget {
  final MemoData memo;
  final DoramaData dorama;
  final Function delete;
  final Function(MemoData) update;
  final bool? isShowDoramaTitle;

  const MemoCardWidget({
    Key? key,
    required this.memo,
    required this.dorama,
    required this.delete,
    required this.update,
    this.isShowDoramaTitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final category = ToolUtil.getMemoCategory(memo.categoryId);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        child: Stack(
          children: <Widget>[
            Container(
              height: 500,
              padding: const EdgeInsets.only(
                top: 50.0,
                right: 0.0,
                bottom: 0.0,
                left: 0.0,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    isShowDoramaTitle != null ?
                    Container(
                      margin: const EdgeInsets.all(30.0),
                      child: Text(
                        dorama.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ) : Container(),
                    Container(
                      margin: const EdgeInsets.all(30.0),
                      child: Text(
                        memo.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 0.0,
                        right: 20.0,
                        bottom: 20.0,
                        left: 20.0,
                      ),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.black38,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                          top: 0.0, right: 20.0, bottom: 0.0, left: 20.0),
                      child: Text(
                        memo.content,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  color: (category != null) ? category.color : Colors.black,
                  /*
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 0, 0, 0),
                        Color.fromARGB(255, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                     */
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        (category != null) ? category.name : '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DeleteDialogWidget(
                                  action: delete,
                                  title: "delete".tr(),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => {
                          Navigator.of(context).push<dynamic>(
                            MaterialPageRoute<dynamic>(
                              builder: (context) {
                                return MemoFormView(
                                  editMemo: memo,
                                  dorama: dorama,
                                  update: update,
                                );
                              },
                            ),
                          )
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.tag),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return MemoTagDialogWidget(memo);
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
