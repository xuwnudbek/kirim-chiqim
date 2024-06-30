import 'dart:developer';

import 'package:bloc_tutor/models/user_data.dart';
import 'package:bloc_tutor/services/http/http_service.dart';
import 'package:bloc_tutor/services/storage/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculateProvider extends ChangeNotifier {
  var name = TextEditingController();
  var secondName = TextEditingController();
  var phone = TextEditingController();

  var summa = TextEditingController();
  bool isQarz = true;
  set isQarzValue(bool value) {
    isQarz = value;
    notifyListeners();
  }

  late bool isCreate;
  late UserData userData;

  CalculateProvider() {
    init();
  }

  void init() {
    if (StorageService.get("user") != null) {
      userData = UserData.fromJson(StorageService.get("user"));
      isCreate = false;
    } else {
      userData = UserData(
        user: User(
          id: 0,
          name: "",
          secondName: "",
          phone: "",
        ),
        qarzlar: [],
        jamiOlinganQarzlar: 0.0,
        jamiTulanganQarzlar: 0.0,
        qolganQarz: 0.0,
      );
      isCreate = true;
    }
    notifyListeners();
  }

  bool isSaving = false;
  bool haveChanges = false;

  Future<void> save() async {
    if (!isCreate && summa.text.isEmpty) return;
    if (isCreate && [name.text, secondName.text, phone.text].any((element) => element.isEmpty)) return;

    isSaving = true;
    notifyListeners();

    var body = {};
    if (isCreate) {
      body = {
        "name": name.text,
        "second_name": secondName.text,
        "phone": phone.text,
      };

      var response = await HttpService.POST(
        URL.users,
        body: body,
      );

      if (response['status'] == HttpResponse.data) {
        body = {
          "amount": int.parse(summa.text.replaceAll(RegExp(r'[^\d]'), "")),
          "user": response['data']['id'],
          "is_qarz": isQarz,
        };

        var res = await HttpService.POST(
          URL.debt,
          body: body,
        );

        if (res['status'] == HttpResponse.data) {
          Get.back();
        }
      }
    } else {
      body = {
        "amount": summa.text,
        "user": userData.user.id,
        "is_qarz": isQarz,
      };

      var res = await HttpService.POST(
        isCreate ? URL.users : URL.debt,
        body: body,
      );

      if (res['status'] == HttpResponse.data) {
        if (isCreate) {
          inspect(res['data']);
        } else {
          userData.qarzlar.insert(0, res['data']);
          if (res['data']['is_qarz']) {
            userData.jamiOlinganQarzlar += res['data']['amount'];
          } else {
            userData.jamiTulanganQarzlar += res['data']['amount'];
          }
        }
        haveChanges = true;
        // StorageService.set("user");
      } else {
        inspect(res['data']);
      }
    }

    summa.clear();

    isSaving = false;
    notifyListeners();
  }
}
