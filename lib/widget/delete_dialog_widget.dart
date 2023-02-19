import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class DeleteDialogWidget extends StatelessWidget {
  final Function action;
  final String title;
  const DeleteDialogWidget({
    Key? key,
    required this.action,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title),
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
        ),
      ],
    );
  }
}
