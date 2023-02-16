import 'dart:math';

import 'package:brain_dump/config/category_config.dart';
import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/model/freezed/dorama_model.dart';
import 'package:brain_dump/repository/dorama_repository.dart';
import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DoramaDatabaseNotifier extends StateNotifier<DoramaStateData> {
  final DoramaRepository _repository = DoramaRepository();

  DoramaDatabaseNotifier() : super(DoramaStateData(doramaItems: [])) {
    fetchData();
  }

  static const _limit = 10;
  int _page = 0;

  ///
  /// データの書き込み
  ///
  writeData(TempDoramaData data) async {
    if (data.title.isEmpty) {
      return;
    }
    DoramaCompanion entry = DoramaCompanion(
      title: Value(data.title),
      categoryId: Value(data.categoryId),
      createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
    );
    state = state.copyWith(isLoading: true);
    await _repository.writeData(entry);
    refresh();
  }

  ///
  /// データ削除
  ///
  deleteData(DoramaData data) async {
    state = state.copyWith(isLoading: true);
    await _repository.delete(data.id);
    refresh();
  }

  ///
  /// データ更新
  ///
  updateData(DoramaData data) async {
    state = state.copyWith(isLoading: true);
    await _repository.update(data);
    refresh();
  }

  ///
  /// リフレッシュ
  ///
  refresh() {
    state = state.copyWith(
      doramaItems: [],
      isLoading: false,
      hasNext: true,
    );
    _page = 0;
    fetchData();
  }

  ///
  /// データ全削除
  ///
  Future<void> deleteAll() async {
    _repository.deleteAll();
    state = state.copyWith(doramaItems: []);
  }

  ///
  /// データ取得
  ///
  Future<void> fetchData() async {
    state = state.copyWith(isLoading: true);

    debugPrint((_page * _limit).toString());

    final List<DoramaData> items = await _repository.fetchData(
      offset: _page * _limit,
      limit: _limit,
    );
    final List<DoramaData> newItems = [...state.doramaItems, ...items];

    if (items.length % _limit != 0 || items.isEmpty) {
      state = state.copyWith(hasNext: false);
    }

    state = state.copyWith(
      isLoading: false,
      isReadyData: true,
      doramaItems: newItems,
    );
    _page++;
  }

  ///
  /// ダミーデータ生成
  ///
  Future<void> createDummyData() async {
    for (var i = 0; i < 100; i++) {
      final item = DoramaCompanion(
        title: Value('Item no. $i'),
        categoryId: Value(Random().nextInt(doramaCategoryItems.length) + 1),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
        updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
      );
      await _repository.writeData(item);
    }
    fetchData();
  }
}

final doramaDatabaseProvider =
    StateNotifierProvider((ref) => DoramaDatabaseNotifier());
