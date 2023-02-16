import 'package:brain_dump/model/db/db.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemoDeleteDialogWidget extends StatelessWidget {
  final MemoData memo;
  final Function action;

  const MemoDeleteDialogWidget({
    Key? key,
    required this.memo,
    required this.action,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("delete".tr()),
      contentPadding: const EdgeInsets.all(16),
      children: <Widget>[
        Text("confirm_delete".tr()),
        ElevatedButton(
          child: Text(
            "delete".tr(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            action();
            Navigator.of(context).pop(true);
          },
        )
      ],
    );
  }
}
