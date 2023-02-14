import 'package:brain_dump/config/enum_config.dart';
import 'package:brain_dump/model/freezed/bottom_navigation_bar_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavigationBarNotifier
    extends StateNotifier<BottomNavigationBarState> {
  BottomNavigationBarNotifier() : super(BottomNavigationBarState());

  void select(BottomTabItem item) {
    state = state.copyWith(viewItem: item);
  }
}

final bottomNavigationBarProvider = StateNotifierProvider<
    BottomNavigationBarNotifier, BottomNavigationBarState>((_) {
  BottomNavigationBarNotifier notifier = BottomNavigationBarNotifier();
  return notifier;
});
