import 'package:brain_dump/view/link_tag/tag_form_view.dart';
import 'package:brain_dump/view/link_tag/widget/tag_tile_widget.dart';
import 'package:brain_dump/view_model/memo/memo_timeline_provider.dart';
import 'package:brain_dump/widget/enpty_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constant_config.dart';
import '../../model/tag_with_count_model.dart';
import '../../view_model/tag/tag_provider.dart';

class TagListView extends ConsumerStatefulWidget {
  const TagListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TagListViewState();
}

class _TagListViewState extends ConsumerState<TagListView> {
  final ScrollController _listScrollController = ScrollController();

  @override
  void initState() {
    _listScrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    final provider = ref.read(tagDatabaseProvider.notifier);
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
    ref.watch(tagDatabaseProvider);
    final provider = ref.watch(tagDatabaseProvider.notifier);
    final timelineProvider = ref.watch(memoTimelineProvider.notifier);
    List<TagWithCountModel> items = provider.state.tagItems;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HexColor(baseColor),
        title: Text(
          "tag_list".tr(),
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
    required List<TagWithCountModel> items,
    required TagDatabaseNotifier provider,
    required MemoTimelineNotifier timelineProvider,
  }) {
    if (items.isEmpty) return EmptyWidget(message: "notice_tag".tr());

    return ListView.builder(
      controller: _listScrollController,
      itemCount: items.length,
      itemBuilder: (context, index) => TagTileWidget(
        data: items[index].tag,
        delete: () async {
          await provider.delete(items[index].tag);
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
          MaterialPageRoute(builder: (context) => const TagFormView()),
        );
      },
    );
  }
}
