import 'package:brain_dump/config/category_config.dart';
import 'package:brain_dump/model/freezed/memo_model.dart';
import 'package:brain_dump/model/select_item_model.dart';
import 'package:brain_dump/view_model/memo/memo_timeline_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/db/db.dart';
import '../../view_model/memo/memo_provider.dart';

class MemoFormView extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final MemoData? editMemo;
  final DoramaData dorama;

  MemoFormView({
    Key? key,
    this.editMemo,
    required this.dorama,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(memoDatabaseProvider(dorama));
    final provider = ref.watch(memoDatabaseProvider(dorama).notifier);
    final timelineProvider = ref.watch(memoTimelineProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.all_inclusive,
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "card_list".tr(),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: _buildForm(
        context: context,
        provider: provider,
        timelineProvider: timelineProvider,
      ),
    );
  }

  Widget _buildForm({
    required BuildContext context,
    required MemoDatabaseNotifier provider,
    required MemoTimelineNotifier timelineProvider,
  }) {
    TempMemoData temp = TempMemoData();
    if (_isEdit()) {
      temp = temp.copyWith(
        title: editMemo!.title,
        content: editMemo!.content,
        categoryId: editMemo!.categoryId,
        dId: dorama.id,
      );
    } else {
      temp = temp.copyWith(dId: dorama.id);
    }
    return ListView(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "category".tr(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.category),
                      ),
                      value: _isEdit()
                          ? memoCategoryItems.firstWhere(
                              (element) => element.id == editMemo!.categoryId)
                          : null,
                      onChanged: (value) {
                        temp = temp.copyWith(categoryId: value!.id);
                      },
                      items: memoCategoryItems.map((SelectItemModel value) {
                        return DropdownMenuItem<SelectItemModel>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return "alert_category".tr();
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "memo".tr(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "notice_memo".tr(),
                        icon: const Icon(Icons.note),
                      ),
                      initialValue: _isEdit() ? editMemo!.title : '',
                      validator: (value) {
                        if (value == '') {
                          return "alert_memo".tr();
                        }
                        return null;
                      },
                      onChanged: (value) {
                        temp = temp.copyWith(title: value);
                      },
                      onSaved: (value) {
                        temp = temp.copyWith(title: value!);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "content".tr(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "notice_content".tr(),
                        icon: const Icon(Icons.playlist_add),
                      ),
                      maxLines: null,
                      minLines: 10,
                      initialValue: _isEdit() ? editMemo!.content : '',
                      validator: (value) {
                        if (value == '') {
                          return "alert_content".tr();
                        }
                        return null;
                      },
                      onChanged: (value) {
                        temp = temp.copyWith(content: value);
                      },
                      onSaved: (value) {
                        temp = temp.copyWith(content: value!);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _buildAddButton(
          context: context,
          action: () {
            if (_formKey.currentState!.validate()) {
              if (_isEdit()) {
                MemoData update = MemoData(
                  id: editMemo!.id,
                  dId: editMemo!.dId,
                  categoryId: temp.categoryId,
                  title: temp.title,
                  content: temp.content,
                  createdAt: editMemo!.createdAt,
                  updatedAt: DateTime.now().millisecondsSinceEpoch,
                );
                provider.updateData(update);
              } else {
                provider.writeData(temp);
                timelineProvider.refresh();
              }
              Navigator.of(context).pop(true);
            }
          },
        ),
      ],
    );
  }

  bool _isEdit() => editMemo != null;

  Widget _buildAddButton({
    required Function action,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: RawMaterialButton(
        onPressed: () => action(),
        elevation: 2.0,
        fillColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(15.0),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.check,
          size: 35.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
