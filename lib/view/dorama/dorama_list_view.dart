import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/view/dorama/dorama_form_view.dart';
import 'package:brain_dump/view/dorama/widget/dorama_tile_widget.dart';
import 'package:brain_dump/view_model/dorama/dorama_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DoramaListView extends HookConsumerWidget {
  const DoramaListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doramaState = ref.watch(doramaDatabaseProvider);
    final doramaProvider = ref.watch(doramaDatabaseProvider.notifier);
    List<DoramaData> items = doramaProvider.state.doramaItems;
    //return Container();
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.all_inclusive,
          color: Colors.black87,
        ),
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
      body: _buildList(items: items, provider: doramaProvider),
      floatingActionButton: _addButton(context),
    );
  }

  Widget _buildList({
    required List<DoramaData> items,
    required DoramaDatabseNotifier provider,
  }) {
    if (items.isEmpty) return _emptyView();

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => DoramaTileWidget(
        data: items[index],
        provider: provider,
      ),
    );
  }

  Widget _emptyView() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Text(
        "notice_dorama".tr(),
        style: const TextStyle(fontSize: 15),
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
