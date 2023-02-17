import 'dart:math';

import 'package:brain_dump/config/category_config.dart';
import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/model/dorama_with_count_model.dart';
import 'package:brain_dump/model/freezed/dorama_model.dart';
import 'package:brain_dump/repository/dorama_repository.dart';
import 'package:brain_dump/repository/memo_repository.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constant_config.dart';

class DoramaDatabaseNotifier extends StateNotifier<DoramaTlStateData> {
  final DoramaRepository _repository = DoramaRepository();

  final MemoRepository _memoRepository = MemoRepository();

  DoramaDatabaseNotifier() : super(DoramaTlStateData(doramaItems: [])) {
    fetchData();
  }

  static const _limit = dataLimit;
  int _page = 0;

  ///
  /// データの書き込み
  ///
  write(TempDoramaData data) async {
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
    await _repository.write(entry);
    refresh();
  }

  ///
  /// データ削除
  ///
  delete(DoramaData data) async {
    state = state.copyWith(isLoading: true);
    await _repository.delete(data.id);
    await _memoRepository.deleteByDId(data.id);
    List<DoramaWithCountModel> items = state.doramaItems;
    //保持リストから削除
    items.removeWhere((element) => element.dorama.id == data.id);
    state = state.copyWith(isLoading: false, doramaItems: items);
  }

  ///
  /// データ更新
  ///
  update(DoramaData data) async {
    state = state.copyWith(isLoading: true);
    await _repository.update(data);
    //refresh();
    List<DoramaWithCountModel> items = state.doramaItems;
    int index = items.indexWhere((element) => element.dorama.id == data.id);
    items[index] = DoramaWithCountModel(data, items[index].count);
    state = state.copyWith(isLoading: false, doramaItems: items);
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
  /// 保持メモ件数をカウントアップ
  ///
  Future<void> countUp(int id) async {
    state = state.copyWith(isLoading: true);
    List<DoramaWithCountModel> items = state.doramaItems;
    int index = items.indexWhere((element) => element.dorama.id == id);
    items[index] =
        DoramaWithCountModel(items[index].dorama, items[index].count + 1);
    state = state.copyWith(isLoading: false, doramaItems: items);
  }

  ///
  /// データ全削除
  ///
  Future<void> deleteAll() async {
    await _repository.deleteAll();
    await _memoRepository.deleteAll();
    state = state.copyWith(doramaItems: []);
  }

  ///
  /// データ取得
  ///
  Future<void> fetchData() async {
    state = state.copyWith(isLoading: true);
    final List<DoramaWithCountModel> items = await _repository.fetchData(
      offset: _page * _limit,
      limit: _limit,
    );
    final List<DoramaWithCountModel> newItems = [
      ...state.doramaItems,
      ...items
    ];

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
      int dId = await _repository.write(item);

      for (var j = 0; j < 10; j++) {
        final memo = MemoCompanion(
          title: Value('Item no. $j'),
          content: Value('Item no. $j'),
          dId: Value(dId),
          categoryId: Value(Random().nextInt(memoCategoryItems.length) + 1),
          createdAt: Value(DateTime.now().millisecondsSinceEpoch),
          updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
        );
        await _memoRepository.write(memo);
      }
    }
    fetchData();
  }
}

final doramaDatabaseProvider =
    StateNotifierProvider((ref) => DoramaDatabaseNotifier());

///
/// ID指定でデータを取得
///
final doramaDetailProvider = FutureProvider.family.autoDispose((ref, int id) {
  final DoramaRepository repository = DoramaRepository();
  return repository.fetchById(id);
});
