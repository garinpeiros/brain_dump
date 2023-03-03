import 'dart:async';

import 'package:brain_dump/config/enum_config.dart';
import 'package:brain_dump/view/dorama/dorama_list_view.dart';
import 'package:brain_dump/view/link_tag/link_tag_view.dart';
import 'package:brain_dump/view/memo/memo_list_view.dart';
import 'package:brain_dump/view_model/top/bottom_navigation_bar_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../data_tramsfer/data_transfer_view.dart';
import '../statistics/statistics_view.dart';

class BeforeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BeforeViewState();
}

class _BeforeViewState extends State<BeforeView> {
  late StreamSubscription _intentDataStreamSubscription;
  List<SharedMediaFile>? _sharedFiles;
  String? _sharedText;

  @override
  void initState() {
    super.initState();
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(() {
        _sharedText = value;
      });
    }, onError: (err) {
      // print("getLinkStream error: $err");
    });
    ReceiveSharingIntent.getInitialText().then((String? value) {
      setState(() {
        _sharedText = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_sharedText != null) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) {
              return DataTransferView(dbFilePath: _sharedText!);
            },
            fullscreenDialog: true,
          ),
        );
      });
    }
    return TopView();
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }
}

class TopView extends HookConsumerWidget {
  TopView({super.key});

  final _views = [
    const DoramaListView(),
    const MemoListView(),
    //DebugView(),
    const TagListView(),
    StatisticsView(),
  ];
  List<BottomTabItem> get _items => BottomTabItem.values;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomTabState = ref.watch(bottomNavigationBarProvider);
    final bottomTabNotifier = ref.watch(bottomNavigationBarProvider.notifier);
    final int currentIndex = _items.indexOf(bottomTabState.viewItem);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
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
            icon: const Icon(Icons.tag),
            label: "tag".tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: "graph".tr(),
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
