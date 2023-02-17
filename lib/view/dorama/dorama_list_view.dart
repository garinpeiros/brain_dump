import 'package:brain_dump/model/dorama_with_count_model.dart';
import 'package:brain_dump/view/dorama/widget/dorama_tile_widget.dart';
import 'package:brain_dump/view_model/dorama/dorama_provider.dart';
import 'package:brain_dump/view_model/memo/memo_timeline_provider.dart';
import 'package:brain_dump/widget/enpty_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dorama_form_view.dart';

class DoramaListView extends ConsumerStatefulWidget {
  const DoramaListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DoramaListViewState();
}

class _DoramaListViewState extends ConsumerState<DoramaListView> {
  final ScrollController _listScrollController = ScrollController();

  @override
  void initState() {
    _listScrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    final provider = ref.read(doramaDatabaseProvider.notifier);
    if (provider.state.isLoading == false && provider.state.hasNext == true) {
      if (_listScrollController.offset >=
              _listScrollController.position.maxScrollExtent &&
          !_listScrollController.position.outOfRange) {
        provider.fetchData();
        EasyLoading.show(status: "loading".tr());
        Future.delayed(const Duration(seconds: 1), () {
          EasyLoading.dismiss(animation: true);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(doramaDatabaseProvider);
    final provider = ref.watch(doramaDatabaseProvider.notifier);
    final timelineProvider = ref.watch(memoTimelineProvider.notifier);
    List<DoramaWithCountModel> items = provider.state.doramaItems;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "dorama_list".tr(),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: _buildList(
        items: items,
        provider: provider,
        timelineProvider: timelineProvider,
      ),
      floatingActionButton: _addButton(context),
    );
  }

  Widget _buildList({
    required List<DoramaWithCountModel> items,
    required DoramaDatabaseNotifier provider,
    required MemoTimelineNotifier timelineProvider,
  }) {
    if (items.isEmpty) return EmptyWidget(message: "notice_dorama".tr());

    return ListView.builder(
      controller: _listScrollController,
      itemCount: items.length,
      itemBuilder: (context, index) => DoramaTileWidget(
        data: items[index].dorama,
        delete: () async {
          await provider.delete(items[index].dorama);
          await timelineProvider.refresh();
        },
        count: items[index].count,
      ),
    );
  }

  Widget _addButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DoramaFormView()),
        );
      },
    );
  }
}
