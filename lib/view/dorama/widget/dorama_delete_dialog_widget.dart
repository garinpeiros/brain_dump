import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../model/db/db.dart';

class DoramaDeleteDialogWidget extends StatelessWidget {
  final DoramaData data;
  final Function action;
  const DoramaDeleteDialogWidget({
    Key? key,
    required this.data,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("delete_dorama".tr()),
      contentPadding: const EdgeInsets.all(16),
      children: <Widget>[
        Text("confirm_delete_dorama".tr()),
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
        ),
      ],
    );
  }
}
