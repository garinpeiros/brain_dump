import 'package:brain_dump/model/select_item_model.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/category_config.dart';

class ToolUtil {
  static SelectItemModel? getDoramaCategory(int categoryId) {
    SelectItemModel? item = doramaCategoryItems
        .firstWhereOrNull((element) => element.id == categoryId);
    return item;
  }

  static SelectItemModel? getMemoCategory(int categoryId) {
    SelectItemModel? item = memoCategoryItems
        .firstWhereOrNull((element) => element.id == categoryId);
    return item;
  }

  static String convertDate(int timestamp) {
    final df = DateFormat('yyyy年MM月dd日 hh時mm分');
    return df.format(DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000));
  }

  static void showLoadingSnackBar(BuildContext context) {
    var snackBar = SnackBar(
      content: Container(
        height: 50,
        alignment: Alignment.center,
        child: Text("loading".tr()),
      ),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
