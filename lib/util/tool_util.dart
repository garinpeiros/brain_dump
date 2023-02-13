import 'package:brain_dump/model/select_item_model.dart';
import 'package:collection/collection.dart';

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
}
