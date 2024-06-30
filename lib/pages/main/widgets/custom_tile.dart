import 'package:bloc_tutor/pages/calculate/calculate_page.dart';
import 'package:bloc_tutor/pages/main/views/payment/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(builder: (context, paymentProvider, _) {
      var userData = paymentProvider.users[index];
      var user = userData['user'];

      return GestureDetector(
        onTap: () async {
          paymentProvider.setUserData(userData);
          var res = await Get.to(() => const CalculatePage());
          if (res ?? false) {
            await paymentProvider.getPayments();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 0.5,
                color: Colors.grey.shade200,
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          child: ListTile(
            dense: true,
            title: Text(
              "${user['name']} ${user['second_name']}",
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "${((userData['jami_tulangan_qarzlar'] ?? 0) * 1.0).toInt()} so'm",
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "${((userData['jami_olingan_qarzlar'] ?? 0) * 1.0).toInt()} so'm",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "${((userData['qolgan_qarz'] ?? 0) * 1.0).toInt()} so'm",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
