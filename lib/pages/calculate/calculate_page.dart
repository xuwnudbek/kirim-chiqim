import 'package:bloc_tutor/pages/calculate/provider/calculate_provider.dart';
import 'package:bloc_tutor/pages/calculate/views/create_view.dart';
import 'package:bloc_tutor/pages/calculate/views/update_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CalculatePage extends StatelessWidget {
  const CalculatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalculateProvider>(
      create: (context) => CalculateProvider(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Get.back(result: context.read<CalculateProvider>().haveChanges);
              },
            ),
            title: const Text(
              'HISOB-KITOB',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: context.watch<CalculateProvider>().isCreate ? const CreateView() : const UpdateView(),
          ),
        );
      },
    );
  }
}
