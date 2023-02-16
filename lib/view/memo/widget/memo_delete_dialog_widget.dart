import 'package:brain_dump/model/db/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemoDeleteDialogWidget extends StatelessWidget {
  final MemoData memo;
  final Function returnAction;

  const MemoDeleteDialogWidget({
    Key? key,
    required this.memo,
    required this.returnAction,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('メモの削除'),
      contentPadding: EdgeInsets.all(16),
      children: <Widget>[
        Text('本当に削除しても宜しいですか？'),
        ElevatedButton(
          child: Text(
            '削除',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            /*
            final viewModel =
                Provider.of<MemoViewModel>(context, listen: false);
            viewModel.delete(memo);
            */
            returnAction();
          },
        )
      ],
    );
  }
}
