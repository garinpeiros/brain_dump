import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/model/freezed/memo_model.dart';
import 'package:brain_dump/repository/memo_repository.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MemoDatabaseNotifier extends StateNotifier<MemoStateData> {
  MemoDatabaseNotifier({required DoramaData dorama}) : super(MemoStateData()) {
    fetchByDorama(dorama.id);
  }

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
  Future<void> write(TempMemoData data) async {
    MemoCompanion entry = MemoCompanion(
      title: Value(data.title),
      content: Value(data.content),
      categoryId: Value(data.categoryId),
      dId: Value(data.dId),
      createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
    );
    state = state.copyWith(isLoading: true);
    await _repository.write(entry);
    state = state.copyWith(isLoading: false);
    refresh(dId: data.dId);
  }

  ///
  /// データ更新
  ///
  Future<void> update(MemoData data) async {
    state = state.copyWith(isLoading: true);
    await _repository.update(data);
    state = state.copyWith(isLoading: false);
    refresh(dId: data.dId);
  }

  ///
  /// データ削除
  ///
  Future<void> delete(MemoData data) async {
    state = state.copyWith(isLoading: true);
    await _repository.delete(data.id);
    refresh(dId: data.dId);
  }

  Future<void> refresh({required int dId}) async {
    fetchByDorama(dId);
  }
}

final memoDatabaseProvider = StateNotifierProvider.family
    .autoDispose<MemoDatabaseNotifier, MemoStateData, DoramaData>(
  (ref, dorama) => MemoDatabaseNotifier(dorama: dorama),
);

final memoCountProvider = FutureProvider.autoDispose((ref) {
  final MemoRepository repository = MemoRepository();
  return repository.count();
});
