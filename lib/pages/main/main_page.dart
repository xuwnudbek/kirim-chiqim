import 'package:bloc_tutor/pages/calculate/calculate_page.dart';
import 'package:bloc_tutor/pages/main/provider/main_provider.dart';
import 'package:bloc_tutor/pages/main/views/payment/payment_view.dart';
import 'package:bloc_tutor/pages/main/views/payment/provider/payment_provider.dart';
import 'package:bloc_tutor/pages/main/widgets/header.dart';
import 'package:bloc_tutor/services/storage/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentProvider(context),
        ),
      ],
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            title: const Text(
              "KIRIM-CHIQIM",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: const Column(
            children: [
              Header(),
              PaymentView(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await StorageService.remove("user");
              Get.to(() => const CalculatePage());
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
