import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/model/freezed/memo_model.dart';
import 'package:brain_dump/model/memo_with_dorama_model.dart';
import 'package:brain_dump/repository/memo_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constant_config.dart';

class MemoTimelineNotifier extends StateNotifier<MemoTlStateData> {
  MemoTimelineNotifier() : super(MemoTlStateData(memoItems: [])) {
    fetchData();
  }

  final MemoRepository _memoRepository = MemoRepository();

  static const _limit = dataLimit;
  int _page = 0;

  ///
  /// データ取得
  ///
  Future<void> fetchData() async {
    state = state.copyWith(isLoading: true);
    final List<MemoWithDoramaModel> items = await _memoRepository.fetch(
      offset: _page * _limit,
      limit: _limit,
    );

    final List<MemoWithDoramaModel> newItems = [...state.memoItems, ...items];

    if (items.length % _limit != 0 || items.isEmpty) {
      state = state.copyWith(hasNext: false);
    }

    state = state.copyWith(
      isLoading: false,
      memoItems: newItems,
    );
    _page++;
  }

  Future<void> refresh() async {
    _page = 0;
    state = state.copyWith(memoItems: []);
    await fetchData();
  }

  ///
  /// 更新
  ///
  Future<void> update(MemoData data) async {
    state = state.copyWith(isLoading: true);
    await _memoRepository.update(data);
    List<MemoWithDoramaModel> items = state.memoItems;
    int index = items.indexWhere((element) => element.memo.id == data.id);
    items[index] = MemoWithDoramaModel(data, items[index].dorama);
    state = state.copyWith(isLoading: false, memoItems: items);
  }

  ///
  /// 削除
  ///
  Future<void> delete(MemoWithDoramaModel data) async {
    await _memoRepository.delete(data.memo.id);
    state = state.copyWith(isLoading: true);
    List<MemoWithDoramaModel> items = state.memoItems;
    items.removeWhere((element) => element.memo.id == data.memo.id);
    state = state.copyWith(isLoading: false, memoItems: items);
  }
}

final memoTimelineProvider =
    StateNotifierProvider((ref) => MemoTimelineNotifier());
