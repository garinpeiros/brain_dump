import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uri_to_file/uri_to_file.dart';

import '../../config/constant_config.dart';
import '../../model/db/db.dart';

class DataTransferView extends HookConsumerWidget {
  final String dbFilePath;

  const DataTransferView({Key? key, required this.dbFilePath})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(Duration.zero, () {
      _action(context);
    });
    return _content(context);
  }

  Widget _content(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("import_description".tr()),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: _okButton(context))),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: _cancelButton(context)))
            ],
          ),
          const SizedBox(height: 60)
        ],
      ),
    );
  }

  _action(BuildContext context) async {
    final db = MyDatabase.getInstance();
    await EasyLoading.show();
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, dbFileName));
    final String path = file.path;
    final dbFile = await toFile(dbFilePath);
    db.close();
    await File(path).delete();
    await File(path).writeAsBytes(await dbFile.readAsBytes());
    db.reset();
    EasyLoading.dismiss();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('import_complete'.tr()),
      ),
    );
  }

  Widget _okButton(BuildContext context) {
    return ElevatedButton(
      child: Text(
        "import".tr(),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        _action(context);
        Navigator.of(context).pop(true);
      },
    );
  }

  Widget _cancelButton(BuildContext context) {
    return ElevatedButton(
      child: Text(
        "cancel".tr(),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );
  }
}
