import 'package:bloc_tutor/pages/main/views/payment/provider/payment_provider.dart';
import 'package:bloc_tutor/pages/main/widgets/custom_tile.dart';
import 'package:bloc_tutor/utils/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(
      builder: (context, paymentProvider, _) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: paymentProvider.isLoading
                ? const LoadingWidget()
                : paymentProvider.users.isEmpty
                    ? SizedBox(
                        width: Get.width * .8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                paymentProvider.getPayments();
                              },
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.grey,
                                weight: 1,
                                size: 50.0,
                              ),
                            ),
                            const Text(
                              "Hozircha hech qanday pul o'tkazmalari mavjud emas",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          await paymentProvider.getPayments();
                        },
                        child: ListView.builder(
                          itemCount: paymentProvider.users.length,
                          controller: paymentProvider.scrollController,
                          itemBuilder: (context, index) {
                            return TweenAnimationBuilder(
                              tween: Tween<double>(begin: 0.1, end: 1.0),
                              duration: const Duration(milliseconds: 400),
                              builder: (context, value, _) {
                                return Transform.scale(
                                  scale: 1,
                                  child: CustomTile(index: index),
                                );
                              },
                            );
                          },
                        ),
                      ),
          ),
        );
      },
    );
  }
}
