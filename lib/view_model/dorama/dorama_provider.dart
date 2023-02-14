import 'dart:math';

import 'package:brain_dump/config/category_config.dart';
import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/model/freezed/dorama_model.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DoramaDatabseNotifier extends StateNotifier<DoramaStateData> {
  DoramaDatabseNotifier() : super(DoramaStateData(doramaItems: [])) {
    //fetchList();
    fetchData();
  }

  static const _limit = 20;
  final _db = MyDatabase();
  int _page = 1;

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
    await _db.writeDorama(entry);
    readData();
  }

  ///
  /// データ削除
  ///
  deleteData(DoramaData data) async {
    if (data.title.isEmpty) {
      return false;
    }
    state = state.copyWith(isLoading: true);
    await _db.deleteDrama(data.id);
    readData();
  }

  ///
  /// データ更新
  ///
  updateData(DoramaData data) async {
    if (data.title.isEmpty) {
      return false;
    }
    state = state.copyWith(isLoading: true);
    await _db.updateDorama(data);
    readData();
  }

  readData() async {
    state = state.copyWith(isLoading: true);
    final items = await _db.readAllDorama();
    state = state.copyWith(
      isLoading: false,
      isReadyData: true,
      doramaItems: items,
    );
  }

  Future<void> fetchList() async {
    state = state.copyWith(isLoading: true);
    final items = await fetchNextDummyList();
    state = state.copyWith(
      isLoading: false,
      isReadyData: true,
      doramaItems: items,
    );
  }

  fetchData() async {
    state = state.copyWith(isLoading: true);
    final List<DoramaData> items =
        await _db.fetchDorama(offset: _page * _limit, limit: _limit);
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
  Future<List<DoramaData>> fetchNextDummyList() async =>
      Future.delayed(const Duration(seconds: 2), () {
        final items = <DoramaData>[];
        for (var i = 0; i < _limit; i++) {
          final id = state.doramaItems.length + i + 1;
          items.add(DoramaData(
            id: id,
            title: 'Item no. $id',
            categoryId: Random().nextInt(doramaCategoryItems.length) + 1,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            updatedAt: DateTime.now().millisecondsSinceEpoch,
          ));
        }
        //spread記法
        return [...state.doramaItems, ...items];
      });
}

/*
final doramaDatabaseProvider = StateNotifierProvider((_) {
  DoramaDatabseNotifier notify = DoramaDatabseNotifier();
  notify.readData();
  return notify;
});
*/
final doramaDatabaseProvider =
    StateNotifierProvider((ref) => DoramaDatabseNotifier());
