import 'package:brain_dump/model/memo_with_dorama_model.dart';
import 'package:brain_dump/view/memo/widget/memo_card_widget.dart';
import 'package:brain_dump/view_model/memo/memo_timeline_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constant_config.dart';

class MemoPageView extends ConsumerStatefulWidget {
  final List<MemoWithDoramaModel> list;
  final int index;
  const MemoPageView({super.key, required this.list, required this.index});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MemoPageViewState();
}

class _MemoPageViewState extends ConsumerState<MemoPageView> {
  late String _doramaName;

  @override
  void initState() {
    super.initState();
    _doramaName = widget.list[widget.index].dorama.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HexColor(baseColor),
        title: Text(
          _doramaName,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: _main(),
      floatingActionButton: FloatingActionButton(
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
    );
  }

  Widget _main() {
    ref.watch(memoTimelineProvider);
    final provider = ref.watch(memoTimelineProvider.notifier);

    List<Widget> list = widget.list
        .map(
          (e) => MemoCardWidget(
            memo: e.memo,
            dorama: e.dorama,
            delete: () => {
              provider.delete(e),
            },
            update: (value) {
              provider.update(value);
            },
          ),
        )
        .toList();
    final double height = MediaQuery.of(context).size.height - 200;
    return _cardSlideList(height: height, textSliders: list);
  }

  Widget _cardSlideList({
    required double height,
    required List<Widget> textSliders,
  }) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              initialPage: widget.index,
              enableInfiniteScroll: false,
              height: height,
              autoPlay: false,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              onPageChanged: (index, _) {
                setState(() {
                  _doramaName = widget.list[index].dorama.title;
                });
              }),
          items: textSliders,
        ),
      ],
    );
  }
}
