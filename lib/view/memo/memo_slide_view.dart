import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/view/memo/widget/memo_card_widget.dart';
import 'package:brain_dump/view_model/dorama/dorama_provider.dart';
import 'package:brain_dump/view_model/memo/memo_provider.dart';
import 'package:brain_dump/view_model/memo/memo_timeline_provider.dart';
import 'package:brain_dump/widget/enpty_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'memo_form_view.dart';

class MemoSlideView extends HookConsumerWidget {
  final DoramaData dorama;

  const MemoSlideView({super.key, required this.dorama});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(memoDatabaseProvider(dorama));
    final provider = ref.watch(memoDatabaseProvider(dorama).notifier);
    final doramaProvider = ref.watch(doramaDatabaseProvider.notifier);
    final timelineProvider = ref.watch(memoTimelineProvider.notifier);

    List<MemoData> items = provider.state.memoItems;

    List<Widget> textSliders = [];
    if (items.isNotEmpty) {
      textSliders = items
          .map(
            (item) => MemoCardWidget(
              memo: item,
              dorama: dorama,
              delete: () {
                provider.deleteData(item);
                doramaProvider.refresh();
                timelineProvider.refresh();
              },
              update: (value) {
                provider.updateData(value);
              },
            ),
          )
          .toList();
    }

    final double height = MediaQuery.of(context).size.height - 200;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          dorama.title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: (items.isNotEmpty)
          ? _cardSlideList(
              height: height,
              textSliders: textSliders,
            )
          : EmptyWidget(
              message: "please_memo".tr(),
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _addMemoButton(
            context: context,
            dorama: dorama,
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
          ),
          FloatingActionButton(
            heroTag: 'back',
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
  }

  Widget _cardSlideList({
    required double height,
    required List<Widget> textSliders,
  }) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: height,
            autoPlay: false,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          items: textSliders,
        ),
      ],
    );
  }

  Widget _addMemoButton({
    required BuildContext context,
    required DoramaData dorama,
  }) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push<dynamic>(
          MaterialPageRoute<dynamic>(
            builder: (context) {
              return MemoFormView(
                editMemo: null,
                dorama: dorama,
                update: (value) {},
              );
            },
          ),
        );
      },
    );
  }
}
