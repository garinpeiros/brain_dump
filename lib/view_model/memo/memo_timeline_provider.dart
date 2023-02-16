import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/model/freezed/memo_model.dart';
import 'package:brain_dump/repository/memo_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MemoTimelineNotifier extends StateNotifier<MemoStateData> {
  MemoTimelineNotifier() : super(MemoStateData(memoItems: [])) {
    fetchData();
  }

  final MemoRepository _repository = MemoRepository();

  static const _limit = 20;
  int _page = 0;

  ///
  /// データ取得
  ///
  Future<void> fetchData() async {
    state = state.copyWith(isLoading: true);
    final List<MemoData> items = await _repository.fetch(
      offset: _page * _limit,
      limit: _limit,
    );
    final List<MemoData> newItems = [...state.memoItems, ...items];

    if (items.length % _limit != 0 || items.isEmpty) {
      state = state.copyWith(hasNext: false);
    }

    state = state.copyWith(
      isLoading: false,
      memoItems: newItems,
    );
    _page++;
  }
}

final memoTimelineProvider =
    StateNotifierProvider((ref) => MemoTimelineNotifier());
