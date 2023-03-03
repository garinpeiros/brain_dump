import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../model/select_item_model.dart';

List<SelectItemModel> memoCategoryItems = [
  SelectItemModel(
    id: 1,
    name: tr("character"),
    color: HexColor("#386CB0"),
  ),
  SelectItemModel(
    id: 2,
    name: tr("serif"),
    color: HexColor("#FF9914"),
  ),
  SelectItemModel(
    id: 3,
    name: tr("composition"),
    color: HexColor("#1AA18E"),
  ),
  SelectItemModel(
    id: 4,
    name: tr("story"),
    color: HexColor("#DF4C94"),
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
    color: HexColor("#0094A1"),
  ),
  SelectItemModel(
    id: 2,
    name: "tv".tr(),
    color: HexColor("#FF9914"),
  ),
  SelectItemModel(
    id: 3,
    name: "manga".tr(),
    color: HexColor("#99D02B"),
  ),
  SelectItemModel(
    id: 4,
    name: "other".tr(),
    color: Colors.grey,
  ),
];
