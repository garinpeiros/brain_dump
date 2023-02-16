import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MemoGageWidget extends StatelessWidget {
  final int currentCount;
  final int maxCount;

  const MemoGageWidget(
      {super.key, required this.currentCount, required this.maxCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: LinearProgressIndicator(
              value: currentCount / maxCount,
              valueColor:
                  AlwaysStoppedAnimation(getCurrentHpColor(currentCount)),
              backgroundColor: Colors.black12,
              minHeight: 2,
            ),
          ),
        ),
      ],
    );
  }

  Color getCurrentHpColor(int hp) {
    if (hp > maxCount * 0.9) {
      return HexColor("#90EE90");
    }
    if (hp > maxCount / 5) {
      return HexColor("#FFBB66");
    }
    return HexColor("#F06060");
  }
}
