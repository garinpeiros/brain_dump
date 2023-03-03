import 'package:brain_dump/config/enum_config.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bottom_navigation_bar_state.freezed.dart';

@freezed
abstract class BottomNavigationBarState with _$BottomNavigationBarState {
  factory BottomNavigationBarState({
    @Default(BottomTabItem.dorama) final BottomTabItem viewItem,
  }) = _BottomNavigationBarState;
}
