import 'package:brain_dump/view/memo/memo_page_view.dart';
import 'package:brain_dump/view/memo/widget/memo_card_tile_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../view_model/memo/memo_timeline_provider.dart';
import '../../widget/enpty_widget.dart';

class MemoListView extends ConsumerStatefulWidget {
  const MemoListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MemoListViewState();
}

class _MemoListViewState extends ConsumerState<MemoListView> {
  final _scrollThreshold = 200.0;
  final ScrollController _listScrollController = ScrollController();

  @override
  void initState() {
    _listScrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    final provider = ref.read(memoTimelineProvider.notifier);
    if (provider.state.isLoading == false && provider.state.hasNext == true) {
      final maxScroll = _listScrollController.position.maxScrollExtent;
      final currentScroll = _listScrollController.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold) {
        provider.fetchData();
        EasyLoading.show(status: "loading".tr());
        Future.delayed(const Duration(seconds: 1), () {
          EasyLoading.dismiss(animation: true);
        });
      }
    }
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(memoTimelineProvider);
    final provider = ref.watch(memoTimelineProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.all_inclusive,
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "card_list".tr(),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: _cardList(provider),
    );
  }

  ///カード一覧
  Widget _cardList(MemoTimelineNotifier provider) {
    final items = provider.state.memoItems;
    if (items.isEmpty) {
      return EmptyWidget(message: "please_timeline".tr());
    }
    return GridView.builder(
      controller: _listScrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => MemoCardTileWidget(
        data: items[index],
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemoPageView(
                list: items,
                index: index,
              ),
            ),
          );
        },
      ),
    );
  }
}
