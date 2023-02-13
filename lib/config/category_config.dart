import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../model/select_item_model.dart';

List<SelectItemModel> memoCategoryItems = [
  SelectItemModel(
    id: 1,
    name: tr("character"),
    color: Colors.blue,
  ),
  SelectItemModel(
    id: 2,
    name: tr("serif"),
    color: Colors.orange,
  ),
  SelectItemModel(
    id: 3,
    name: tr("composition"),
    color: Colors.green,
  ),
  SelectItemModel(
    id: 4,
    name: tr("story"),
    color: Colors.red,
  ),
  SelectItemModel(
    id: 5,
    name: tr("idea_item"),
    color: Colors.purple,
  ),
];

List<SelectItemModel> doramaCategoryItems = [
  SelectItemModel(
    id: 1,
    name: "cinema".tr(),
    color: Colors.blue,
  ),
  SelectItemModel(
    id: 2,
    name: "tv".tr(),
    color: Colors.orange,
  ),
  SelectItemModel(
    id: 3,
    name: "manga".tr(),
    color: Colors.green,
  ),
  SelectItemModel(
    id: 4,
    name: "other".tr(),
    color: Colors.grey,
  ),
];
