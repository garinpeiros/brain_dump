import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/model/freezed/dorama_model.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DoramaDatabseNotifier extends StateNotifier<DoramaStateData> {
  DoramaDatabseNotifier() : super(DoramaStateData());

  final _db = MyDatabase();

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
}

final doramaDatabaseProvider = StateNotifierProvider((_) {
  DoramaDatabseNotifier notify = DoramaDatabseNotifier();
  notify.readData();
  return notify;
});
