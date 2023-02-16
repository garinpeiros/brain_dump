import 'package:brain_dump/view/memo/widget/memo_card_tile_widget.dart';
import 'package:brain_dump/widget/enpty_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../util/tool_util.dart';
import '../../view_model/memo/memo_timeline_provider.dart';

class MemoListView extends ConsumerStatefulWidget {
  const MemoListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MemoListViewState();
}

class _MemoListViewState extends ConsumerState<MemoListView> {
  final ScrollController _listScrollController = ScrollController();

  @override
  void initState() {
    _listScrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    final provider = ref.read(memoTimelineProvider.notifier);
    if (provider.state.isLoading == false && provider.state.hasNext == true) {
      if (_listScrollController.offset >=
              _listScrollController.position.maxScrollExtent &&
          !_listScrollController.position.outOfRange) {
        ToolUtil.showLoadingSnackBar(context);
      }
    }
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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => MemoCardTileWidget(
        memo: items[index],
        onTap: () {},
      ),
    );
  }
}
