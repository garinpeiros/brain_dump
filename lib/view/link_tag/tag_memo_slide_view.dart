import 'package:brain_dump/model/memo_with_dorama_model.dart';
import 'package:brain_dump/view_model/tag/tag_memo_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constant_config.dart';
import '../../model/db/db.dart';
import '../../widget/enpty_widget.dart';
import '../memo/widget/memo_card_widget.dart';

class TagMemoSlideView extends HookConsumerWidget {
  final LinkTagData tag;

  const TagMemoSlideView({super.key, required this.tag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tagMemoDatabaseProvider(tag));
    final provider = ref.watch(tagMemoDatabaseProvider(tag).notifier);
    List<MemoWithDoramaModel> items = provider.state.memoItems;
    final double height = MediaQuery.of(context).size.height - 200;

    List<Widget> textSliders = [];
    textSliders = items
        .map(
          (item) => MemoCardWidget(
            memo: item.memo,
            dorama: item.dorama,
            delete: () {
              //provider.delete(item);
            },
            update: (value) {
              //provider.update(value);
            },
          ),
        )
        .cast<Widget>()
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HexColor(baseColor),
        title: Text(
          tag.title,
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
              message: "#${"please_tag".tr()}",
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
}
