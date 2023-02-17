import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/model/freezed/dorama_model.dart';
import 'package:brain_dump/model/select_item_model.dart';
import 'package:brain_dump/view_model/dorama/dorama_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/category_config.dart';

class DoramaFormView extends HookConsumerWidget {
  final DoramaData? data;
  const DoramaFormView({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(doramaDatabaseProvider);
    final doramaProvider = ref.watch(doramaDatabaseProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.all_inclusive,
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          _isEdit() ? "edit_dorama".tr() : "add_dorama".tr(),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: _buildForm(context, doramaProvider),
    );
  }

  bool _isEdit() => data != null;

  Widget _buildForm(BuildContext context, DoramaDatabaseNotifier provider) {
    final key = GlobalKey<FormState>();
    TempDoramaData temp = TempDoramaData();

    if (_isEdit()) {
      temp = temp.copyWith(categoryId: data!.categoryId);
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
                      "category".tr(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        hintText: "category".tr(),
                        icon: const Icon(Icons.category),
                      ),
                      value: _isEdit()
                          ? doramaCategoryItems.firstWhere(
                              (element) => element.id == data!.categoryId)
                          : null,
                      onChanged: (value) {
                        temp = temp.copyWith(categoryId: value!.id);
                      },
                      items: doramaCategoryItems.map((SelectItemModel value) {
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
                      "title".tr(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "product_name".tr(),
                        icon: const Icon(Icons.bookmark_border),
                      ),
                      initialValue: _isEdit() ? data!.title : '',
                      validator: (value) {
                        if (value == '') {
                          return "alert_title".tr();
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
                DoramaData update = DoramaData(
                  id: data!.id,
                  categoryId: temp.categoryId,
                  title: temp.title,
                  createdAt: data!.createdAt,
                  updatedAt: DateTime.now().millisecondsSinceEpoch,
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
