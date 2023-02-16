import 'package:brain_dump/model/memo_with_dorama_model.dart';
import 'package:brain_dump/view/memo/widget/memo_card_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          backgroundColor: Colors.white,
          title: Text(
            _doramaName,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: _main());
  }

  Widget _main() {
    List<Widget> list = widget.list
        .map(
          (e) => MemoCardWidget(
            memo: e.memo,
            dorama: e.dorama,
            delete: () => {},
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
