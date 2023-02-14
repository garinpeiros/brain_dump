import 'dart:math';

import 'package:brain_dump/config/category_config.dart';
import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/model/freezed/dorama_model.dart';
import 'package:brain_dump/repository/dorama_repository.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DoramaDatabseNotifier extends StateNotifier<DoramaStateData> {
  final DoramaRepository _repository = DoramaRepository();

  DoramaDatabseNotifier() : super(DoramaStateData(doramaItems: [])) {
    //fetchList();
    fetchData();
  }

  static const _limit = 10;
  final _db = MyDatabase();
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
    //await _db.writeDorama(entry);
    await _repository.writeData(entry);
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

  /*
  Future<void> fetchList() async {
    state = state.copyWith(isLoading: true);
    final items = await fetchNextDummyList();
    state = state.copyWith(
      isLoading: false,
      isReadyData: true,
      doramaItems: items,
    );
  }
  */

  ///
  /// データ全削除
  ///
  Future<void> deleteAll() async {
    _repository.deleteAll();
    state = state.copyWith(doramaItems: []);
  }

  Future<void> fetchData() async {
    state = state.copyWith(isLoading: true);

    print(_page * _limit);
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
    StateNotifierProvider((ref) => DoramaDatabseNotifier());
