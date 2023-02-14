import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/model/freezed/memo_model.dart';
import 'package:brain_dump/repository/memo_repository.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MemoDatabaseNotifier extends StateNotifier<MemoStateData> {
  MemoDatabaseNotifier() : super(MemoStateData());

  final MemoRepository _repository = MemoRepository();

  ///
  /// ドラマ単位でデータを取得
  ///
  Future<void> fetchByDorama(int dId) async {
    state = state.copyWith(isLoading: true);
    final List<MemoData> items = await _repository.fetchDataByDorama(dId);
    state = state.copyWith(memoItems: items, isLoading: false);
  }

  ///
  /// データ登録
  ///
  Future<void> writeData(TempMemoData data) async {
    MemoCompanion entry = MemoCompanion(
      title: Value(data.title),
      content: Value(data.content),
      categoryId: Value(data.categoryId),
      createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
    );
    state = state.copyWith(isLoading: true);
    await _repository.writeData(entry);
    //refresh();
  }
}
