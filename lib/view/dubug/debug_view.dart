import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../view_model/dorama/dorama_provider.dart';

class DebugView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(doramaDatabaseProvider);
    final provider = ref.watch(doramaDatabaseProvider.notifier);
    return _main(provider, context);
  }

  Widget _main(DoramaDatabaseNotifier provider, BuildContext context) {
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
          ),
        ],
      ),
    );
  }

  /*
  void _dlAction(BuildContext context) async {
    var dir = await getApplicationDocumentsDirectory();
    var dbPath = '${dir.path}/db.sqlite';
    print(dbPath);
  }

   */
}
