import 'package:brain_dump/config/enum_config.dart';
import 'package:brain_dump/view/dorama/dorama_list_view.dart';
import 'package:brain_dump/view/dubug/debug_view.dart';
import 'package:brain_dump/view/memo/memo_view.dart';
import 'package:brain_dump/view_model/top/bottom_navigation_bar_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopView extends HookConsumerWidget {
  TopView({super.key});

  final _views = [
    DoramaListView(),
    MemoView(),
    DebugView(),
  ];
  List<BottomTabItem> get _items => BottomTabItem.values;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomTabState = ref.watch(bottomNavigationBarProvider);
    final bottomTabNotifier = ref.watch(bottomNavigationBarProvider.notifier);
    final int currentIndex = _items.indexOf(bottomTabState.viewItem);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.movie_creation_outlined),
            label: "dorama".tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.crop_square),
            label: "card".tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: "debug".tr(),
          ),
        ],
        onTap: (int selectIndex) {
          bottomTabNotifier.select(_items[selectIndex]);
        },
        currentIndex: currentIndex,
      ),
      body: _views[currentIndex],
    );
  }
}
