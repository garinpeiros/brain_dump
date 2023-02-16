import 'package:brain_dump/view_model/memo/memo_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../view_model/dorama/dorama_provider.dart';

class DebugView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(doramaDatabaseProvider);
    final provider = ref.watch(doramaDatabaseProvider.notifier);
    return _main(provider);
  }

  Widget _main(DoramaDatabaseNotifier provider) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          const SizedBox(height: 200),
          TextButton(
            onPressed: () => {provider.createDummyData()},
            child: const Text('ドラマデータ一括生成'),
          ),
          const SizedBox(height: 100),
          TextButton(
            onPressed: () => {
              provider.deleteAll(),
            },
            child: const Text('ドラマデータ一括削除'),
          )
        ],
      ),
    );
  }
}
