import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uri_to_file/uri_to_file.dart';

import '../../model/db/db.dart';

class DataTransferView extends StatelessWidget {
  final String dbFilePath;

  const DataTransferView({Key? key, required this.dbFilePath})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      _action();
    });
    return Container();
  }

  _action() async {
    final db = MyDatabase.getInstance();
    await EasyLoading.show();
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    final String path = file.path;
    final dbFile = await toFile(dbFilePath);
    db.close();
    await File(path).delete();
    await File(path).writeAsBytes(await dbFile.readAsBytes());
    db.reset();
    EasyLoading.dismiss();
  }
}
