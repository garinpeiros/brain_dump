import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              backgroundColor: Colors.grey,
              minHeight: 2,
            ),
          ),
        ),
        /*
        Text(
          '${currentCount.toString().padLeft(4, '  ')}/$maxCount',
          style: TextStyle(
            fontSize: 10,
          ),
        ),

         */
      ],
    );
  }

  Color getCurrentHpColor(int hp) {
    if (hp > maxCount / 2) {
      return const Color(0xFF00D308);
    }
    if (hp > maxCount / 5) {
      return const Color(0xFFFFC107);
    }
    return const Color(0xFFFF0707);
  }
}
