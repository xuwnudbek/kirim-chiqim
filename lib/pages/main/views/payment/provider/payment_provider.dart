import 'package:bloc_tutor/pages/main/provider/main_provider.dart';
import 'package:bloc_tutor/services/http/http_service.dart';
import 'package:bloc_tutor/services/storage/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentProvider extends ChangeNotifier {
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  Map data = {};
  List users = [];

  PaymentProvider(BuildContext context) {
    getPayments();

    context.read<MainProvider>().searchController.addListener(() {
      filterUsers(context);
    });
  }

  void filterUsers(BuildContext context) {
    var search = context.read<MainProvider>().searchController.text;
    if (search.isNotEmpty) {
      users = data["users"].where((user) => user["user"]["name"].toString().toLowerCase().contains(search.toLowerCase())).toList();
      users = data["users"].where((user) => (user["user"]["second_name"] ?? "").toString().toLowerCase().contains(search.toLowerCase())).toList();
    } else {
      users = data["users"];
    }

    notifyListeners();
  }

  void filterWithDateRange() {}

  bool isLoading = false;
  Future getPayments() async {
    isLoading = true;
    notifyListeners();

    var response = await HttpService.GET(URL.users);
    if (response["status"] == HttpResponse.data) {
      data = response["data"];
      users = data["users"];

      notifyListeners();
    }

    isLoading = false;
    notifyListeners();
  }

  void setUserData(Map userData) {
    StorageService.set("user", userData);
    notifyListeners();
  }
}


/*
{
  "users": [
      {
            "user": {
                "id": 120,
                "name": "name 99",
                "second_name": "second_name99",
                "phone": "phone99"
            },
            "qarzlar": [
                {
                    "id": 2160,
                    "amount": 1000.0,
                    "date": "2024-06-07T14:56:43.698460Z",
                    "is_qarz": true,
                    "user": 120
                },
                {
                    "id": 2159,
                    "amount": 1000.0,
                    "date": "2024-06-07T14:56:43.694341Z",
                    "is_qarz": true,
                    "user": 120
                },
                {
                    "id": 2158,
                    "amount": 1000.0,
                    "date": "2024-06-07T14:56:43.689346Z",
                    "is_qarz": true,
                    "user": 120
                },
                {
                    "id": 2157,
                    "amount": 1000.0,
                    "date": "2024-06-07T14:56:43.685297Z",
                    "is_qarz": true,
                    "user": 120
                },
                {
                    "id": 1680,
                    "amount": 1000.0,
                    "date": "2024-06-07T14:56:18.644883Z",
                    "is_qarz": true,
                    "user": 120
                },
                {
                    "id": 1679,
                    "amount": 1000.0,
                    "date": "2024-06-07T14:56:18.641243Z",
                    "is_qarz": true,
                    "user": 120
                },
                {
                    "id": 1678,
                    "amount": 1000.0,
                    "date": "2024-06-07T14:56:18.637554Z",
                    "is_qarz": true,
                    "user": 120
                },
                {
                    "id": 1677,
                    "amount": 1000.0,
                    "date": "2024-06-07T14:56:18.633357Z",
                    "is_qarz": true,
                    "user": 120
                },
                {
                    "id": 1200,
                    "amount": 400.0,
                    "date": "2024-06-07T14:33:46.705139Z",
                    "is_qarz": false,
                    "user": 120
                },
                {
                    "id": 1199,
                    "amount": 400.0,
                    "date": "2024-06-07T14:33:46.700404Z",
                    "is_qarz": false,
                    "user": 120
                },
                {
                    "id": 1198,
                    "amount": 400.0,
                    "date": "2024-06-07T14:33:46.696796Z",
                    "is_qarz": false,
                    "user": 120
                },
                {
                    "id": 1197,
                    "amount": 400.0,
                    "date": "2024-06-07T14:33:46.693553Z",
                    "is_qarz": false,
                    "user": 120
                },
                {
                    "id": 1196,
                    "amount": 400.0,
                    "date": "2024-06-07T14:33:46.690175Z",
                    "is_qarz": false,
                    "user": 120
                },
                {
                    "id": 600,
                    "amount": 1000.0,
                    "date": "2024-06-07T14:33:25.096588Z",
                    "is_qarz": true,
                    "user": 120
                },
                {
                    "id": 599,
                    "amount": 1000.0,
                    "date": "2024-06-07T14:33:25.091740Z",
                    "is_qarz": true,
                    "user": 120
                },
                {
                    "id": 598,
                    "amount": 1000.0,
                    "date": "2024-06-07T14:33:25.087391Z",
                    "is_qarz": true,
                    "user": 120
                },
                {
                    "id": 597,
                    "amount": 1000.0,
                    "date": "2024-06-07T14:33:25.082595Z",
                    "is_qarz": true,
                    "user": 120
                },
                {
                    "id": 596,
                    "amount": 1000.0,
                    "date": "2024-06-07T14:33:25.078408Z",
                    "is_qarz": true,
                    "user": 120
                }
            ],
            "jami_olingan_qarzlar": 13000.0,
            "jami_tulangan_qarzlar": 2000.0,
            "qolgan_qarz": 11000.0
        },
    ],
    "jami_qarzlar": 1560000.0,
    "jami_tulangan_qarzlar": 240000.0,
    "jami_qolgan_qarzlar": 1320000.0
}


*/