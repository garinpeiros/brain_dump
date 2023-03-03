import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/view_model/dorama/dorama_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constant_config.dart';
import '../../model/freezed/tag_model.dart';
import '../../view_model/tag/tag_provider.dart';

class TagFormView extends HookConsumerWidget {
  final LinkTagData? data;
  const TagFormView({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(doramaDatabaseProvider);
    final tagProvider = ref.watch(tagDatabaseProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HexColor(baseColor),
        title: Text(
          _isEdit() ? "edit_tag".tr() : "add_tag".tr(),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
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
      body: _buildForm(context, tagProvider),
    );
  }

  bool _isEdit() => data != null;

  Widget _buildForm(BuildContext context, TagDatabaseNotifier provider) {
    final key = GlobalKey<FormState>();
    TempTagData temp = TempTagData();

    if (_isEdit()) {
      temp = temp.copyWith(title: data!.title);
    }

    return ListView(
      children: [
        Form(
          key: key,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "title".tr(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "tag_name".tr(),
                        icon: const Icon(Icons.tag),
                      ),
                      initialValue: _isEdit() ? data!.title : '',
                      validator: (value) {
                        if (value == '') {
                          return "alert_tag_name".tr();
                        }
                        return null;
                      },
                      onSaved: (value) {
                        temp = temp.copyWith(title: value);
                      },
                      onChanged: (value) {
                        temp = temp.copyWith(title: value);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        _buildAddButton(
          action: () {
            if (key.currentState!.validate()) {
              if (_isEdit()) {
                LinkTagData update = LinkTagData(
                  id: data!.id,
                  title: temp.title,
                  createdAt: data!.createdAt,
                  updatedAt: DateTime.now().millisecondsSinceEpoch,
                  colorId: 0,
                );
                provider.update(update);
              } else {
                provider.write(temp);
              }
              Navigator.of(context).pop(true);
            }
          },
          context: context,
        ),
      ],
    );
  }

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
